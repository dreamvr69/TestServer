class PushChannel
  include Mongoid::Document

  field :name
  field :description

  belongs_to :franchise, optional: true
  belongs_to :club, optional: true

  has_and_belongs_to_many :users
end
