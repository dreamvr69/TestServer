require 'gcm'

class Push
  include Mongoid::Document
  include AASM

  after_create :check_delivery_date
  default_scope  { order(delivery_date: :desc) }

  field :title
  field :text
  field :aasm_state
  field :delivery_date, type: DateTime

  belongs_to :creator, class_name: 'User', inverse_of: :created_pushes
  has_and_belongs_to_many :users

  aasm do
    state :waiting, initial: true
    state :pushed
    state :canceled
    event :send_push do
      transitions from: [:waiting], to: :pushed
    end
  end

  def check_delivery_date
    if self.delivery_date.nil?
      self.send_to_devices
      self.delivery_date = DateTime.now
      self.save
    else
      SendPushJob.set(wait_until: self.delivery_date).perform_later(self.id.to_s)
    end
  end

  def send_to_devices
    registration_ids = []
    self.users.each do |user|
      user.client_devises.each do |devise|
        registration_ids << devise.token
      end
    end
    gcm = GCM.new(Rails.application.secrets.gcm_api_key)
    options = {data: {title: self.title, message: self.text}}
    gcm.send(registration_ids, options)
    self.send_push!
  end

end
