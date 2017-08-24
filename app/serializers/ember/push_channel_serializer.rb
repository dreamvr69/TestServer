class Ember::PushChannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :franchise_id, :club_id, :user_ids
end
