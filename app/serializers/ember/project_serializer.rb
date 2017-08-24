class Ember::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :author_name, :rooms, :visualization_ids

  def author_name
    begin
      User.find(object.user_id).name
    end
  end

  def rooms
    visualizations = object.visualizations
    set = Set.new

    visualizations.each {|v| set.add(v.room)}

    return set
  end
end
