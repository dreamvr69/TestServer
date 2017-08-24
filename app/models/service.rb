class Service
  include Mongoid::Document
  extend Enumerize

  TYPES = [:base, :extra]

  field :name
  field :description
  field :price, default: "0"

  enumerize :type, in: TYPES, default: :base

  belongs_to :franchise, optional: true
  has_and_belongs_to_many :clubs
end
