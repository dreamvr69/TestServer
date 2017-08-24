class Ember::PushSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :delivery_date, :creator_id, :user_ids, :aasm_state
end
