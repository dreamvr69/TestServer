class Mobile::ClientDeviseSerializer < ActiveModel::Serializer
  attributes :os_type, :user_id, :token
end
