class Comment
  include Mongoid::Document

  belongs_to :visualization
  belongs_to :user

  field :body
end
