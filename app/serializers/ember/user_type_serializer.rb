class Ember::UserTypeSerializer < ActiveModel::Serializer
  attributes :id, :name,  :role_ids, :club_id, :description, :is_owner, :is_franchise_admin

  def is_owner
    @object.roles.count == 1 && @object.roles[0].name == "fitclubs_administrator"
  end

  def is_franchise_admin
    @object.roles.count == 1 && @object.roles[0].name == "franchise_administrator"
  end

end
