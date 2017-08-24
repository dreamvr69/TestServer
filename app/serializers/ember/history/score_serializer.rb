class Ember::History::ScoreSerializer < ActiveModel::Serializer
  attributes :id, :type, :score, :comment, :client_id, :manager_id, :created_at
end
