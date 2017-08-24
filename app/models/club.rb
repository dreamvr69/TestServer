class Club
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :generate_shedule, :copy_services

  field :name
  field :description
  field :phone
  field :address
  field :website_link

  field :vk_link
  field :twitter_link
  field :facebook_link
  field :instagram_link

  field :vk_share_score, type: Integer
  field :twitter_share_score, type: Integer
  field :facebook_share_score, type: Integer
  field :instagram_share_score, type: Integer

  field :vk_share_per_day, type: Integer
  field :twitter_share_per_day, type: Integer
  field :facebook_share_per_day, type: Integer
  field :instagram_share_per_day, type: Integer

  field :first_level_min_score,  type: Integer, default: 100
  field :second_level_min_score, type: Integer, default: 200
  field :third_level_min_score,  type: Integer, default: 300
  field :fourth_level_min_score, type: Integer, default: 400
  field :fifth_level_min_score,  type: Integer, default: 500

  field :max_score_per_day

  belongs_to              :franchise
  has_and_belongs_to_many :users
  has_many                :workouts, dependent: :destroy
  has_one                 :club_shedule,       class_name: 'Club::Shedule', dependent: :destroy
  has_many                :club_images,        class_name: 'Club::Image'
  has_many                :ticket_recalls,    class_name: 'Ticket::Recall',    dependent: :destroy
  has_many                :ticket_freezings,  class_name: 'Ticket::Freezing',  dependent: :destroy
  has_many                :ticket_extensions, class_name: 'Ticket::Extension', dependent: :destroy
  has_many                :ticket_messages,   class_name: 'Ticket::Message',   dependent: :destroy
  has_many                :news,                                               dependent: :destroy
  has_many                :coaches
  has_many                :tutorings, dependent: :destroy
  has_many                :qrs,       dependent: :destroy
  has_and_belongs_to_many :services
  has_many                :card_templates, class_name: 'Card::Template', dependent: :destroy
  has_many                :training_packages, dependent: :destroy
  has_many :reward_templates, class_name: 'Reward::Template', dependent: :destroy
  has_many :schedule_templates, dependent: :destroy
  has_many :shares

  def generate_shedule
    Club::Shedule.create(club: self)
  end

  def copy_services
    self.franchise.services.each do |service|
      service.clubs << self
      service.save!
    end
  end
end
