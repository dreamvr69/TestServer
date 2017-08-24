class Ember::ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :type, :club_ids, :franchise_id
end
