class TrainingPackage
  include Mongoid::Document

  field :name
  field :training_count, type: Integer, default: 0
  field :price

  belongs_to :club
  has_and_belongs_to_many :coaches
end
