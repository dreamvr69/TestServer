class Ember::UserSerializer < ActiveModel::Serializer
  attributes :id, :name,  :email, :mobile, :club_ids, :franchise_id, :tutoring_ids, :is_admin, :is_owner,
             :ticket_recall_ids, :ticket_freezing_ids, :ticket_extension_ids, :ticket_message_ids, :auth_date, :is_client,
             :is_admin_or_owner, :roles_list, :user_type_id, :password, :age, :sex, :loyalty_id, :selected_club_id,
             :selected_club_name, :selected_franchise_name, :quick_save_id

  def selected_club_name
    if @object.selected_club.present?
      @object.selected_club.name
    else
      ''
    end
  end

  def selected_franchise_name
    if @object.selected_club.present?
      @object.selected_club.franchise.name
    else
      ''
    end
  end

  def is_owner
    @object.is_owner
  end

  def is_client
    @object.is_client
  end

  def is_admin
    @object.is_admin
  end

  def is_admin_or_owner
    @object.is_owner || @object.is_admin
  end

  def roles_list
    @object.current_roles_list.select(&:present?)
  end

end
