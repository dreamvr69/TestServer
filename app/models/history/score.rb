class History::Score
  include Mongoid::Document
  include Mongoid::Timestamps
  extend  Enumerize

  TYPES = [:qr, :sharing, :custom]

  field :score, type: Integer, default: 0
  field :comment, type: String

  enumerize :type, in: TYPES

  belongs_to :client,  class_name: 'User', inverse_of: :history_rewards
  belongs_to :manager, class_name: 'User', inverse_of: :history_rewards, optional: true
end
