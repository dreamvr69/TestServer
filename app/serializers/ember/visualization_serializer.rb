class Ember::VisualizationSerializer < ActiveModel::Serializer
  attributes :id, :data, :vr_data, :room, :begin, :end
end
