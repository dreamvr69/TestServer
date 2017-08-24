class Project
  include Mongoid::Document

  belongs_to :user
  has_many :visualizations

  field :begin, type: DateTime
  field :end, type: DateTime
  field :event_name
  field :client_name
  field :company_name

end
