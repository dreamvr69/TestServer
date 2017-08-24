class User
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize
  rolify
  devise :database_authenticatable, :trackable

  SEXES = [:male, :female]

  scope :not_clients, -> {where(:id.nin => User.with_role(:client).pluck(:id))}
  scope :clients,     -> {where(:id.in  => User.with_role(:client).pluck(:id))}
  scope :franchise_users, -> {where(:id.nin  => User.with_any_role(:client, :fitclubs_administrator).pluck(:id))}
  scope :club_users, -> {where(:id.nin => User.with_any_role(:client, :franchise_administrator, :fitclubs_administrator).pluck(:id))}

  #before_save   :ensure_authentication_token
  after_create  :create_loyalty
  after_create  :create_card
  after_create  :assign_default_role
  after_create  :assign_selected_club
  after_save    :assign_roles

  #before_save :set_default_role

  field :quick_save_id

  field :old_user_type_id, default: nil
  field :age, type: Integer, default: 0

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :auth_date,          type: DateTime

  field :name
  field :mobile
  field :authentication_token
  field :last_sms_request,   type: DateTime

  field :franchise_id

  field :user_role, type: String, default: ''

  belongs_to              :franchise,                                                      optional: true
  belongs_to              :selected_club,         class_name: 'Club',                      optional: true
  has_one                 :card,                                                           dependent: :destroy
  belongs_to              :loyalty,                                                        dependent: :destroy, optional: true
  has_and_belongs_to_many :clubs
  has_many                :ticket_recalls,        class_name: 'Ticket::Recall',            dependent: :destroy
  has_many                :ticket_freezings,      class_name: 'Ticket::Freezing',          dependent: :destroy
  has_many                :ticket_extensions,     class_name: 'Ticket::Extension',         dependent: :destroy
  has_many                :ticket_messages,       class_name: 'Ticket::Message',           dependent: :destroy
  has_many                :ticket_tutorings,      class_name: 'Ticket::TutoringRequest',   dependent: :destroy
  has_many                :ticket_workouts,       class_name: 'Ticket::WorkoutRequest',    dependent: :destroy
  has_many                :tutorings,                                                      dependent: :destroy
  has_many                :rewards
  has_and_belongs_to_many :workouts
  has_many                :client_devises,                                                 dependent: :destroy
  has_many                :news
  has_many                :shares
  has_many :history_rewards, class_name: 'History::Reward', inverse_of: :client, dependent: :destroy
  has_many :created_pushes,  class_name: 'Push', inverse_of: :creator, dependent: :destroy
  has_and_belongs_to_many :pushes
  has_and_belongs_to_many :push_channels

  belongs_to              :user_type, optional: true

  has_many                :projects, class_name: "Project"


  enumerize :sex, in: SEXES, default: :male

  def current_roles_list
    roles.map(&:name)
  end

  def assign_roles
    if self.user_type.present?
      if old_user_type_id.nil? || (old_user_type_id != self.user_type_id)
        self.roles = []
        self.user_type.roles.each do |role|
          self.roles << role
        end
        self.old_user_type_id = self.user_type_id
        self.save
      end
    end
  end

  def assign_selected_club
    if self.selected_club.blank?
      self.selected_club = self.clubs.first
      self.save!
    end
  end

  def generate_password
    generated_password = sprintf('%04d', rand(9999))
    self.password = generated_password
    self.save!
    generated_password
  end

  def send_password_via_sms
    if self.last_sms_request.present? && ((DateTime.now - self.last_sms_request) * 24 * 60 ).to_i <= 5
      raise SendSMSException
    else
      sms = Smsc::Sms.new(Rails.application.secrets.smsc_login, Rails.application.secrets.smsc_password)
      sms.message(self.password.to_s, [self.mobile.to_s])
      self.last_sms_request = DateTime.now
      self.save!
    end
  end

  def create_loyalty
    if self.franchise.present?
      Loyalty.create(franchise: self.franchise, user: self)
    end
  end

  def create_card
    if self.franchise.present?
      Card.create(franchise: self.franchise, user: self)
    end
  end

  def assign_default_role
    # Блок сделан серверником. Пока не убран, потому что хз как на фронте происходит
    self.add_role(:client) if self.roles.blank?

    # Блок дял нового сервера
    if user_role.empty?
      user_role = 'manager'
    end
  end

  def set_default_role
    if user_role.empty?
      self.user_role = 'manager'
    end
  end

  def login=(login)
    @login = login
  end

  def login
    if self.mobile.present?
      self.mobile
    else
      self.email
    end
  end

  def is_client
    (self.roles.size == 1) && (self.has_role? :client)
  end

  def is_owner
    self.has_role? :fitclubs_administrator
  end

  def is_admin
    # self.has_role? :franchise_administrator
    true
  end

  def is_super_user?
    user_role == 'super_user'
  end

  def is_franshise_admin?
    user_role == 'franchise_administrator'
  end

  def can_read_owned_by_user?(user_id)
    if is_super_user?
      return true
    elsif is_franshise_admin? && User.find(user_id).franchise_id==franchise_id
      return true
    else
      return (BSON::ObjectId.from_string(user_id) == _id)
    end
  end

  def can_write_owned_by_user?(user_id)
    is_super_user? || user_id == _id.toString()
  end

  def can_read_owned_by_franchise?(franchise_id)
    is_super_user || (is_franchise_admin? && franchise_id == self.franchise_id)
  end

  def can_create_project?(franchise_id)
    is_super_user || franchise_id == self.franchise_id
  end

  def quick_save(visualization)
    self.quick_save_id = "f6"
  end


  private
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
