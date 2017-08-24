class Mobile::ServiceSerializer < ActiveModel::Serializer
  attributes :name, :description, :price, :type
end
