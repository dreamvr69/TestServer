class Visualization
  include Mongoid::Document
  field :data, type: String
  field :vr_data, type: String
  field :room
  field :begin, type: DateTime
  field :end, type: DateTime


  belongs_to :project, optional: true
end
