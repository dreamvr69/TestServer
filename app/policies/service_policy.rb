class ServicePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator)
  end

  def update?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator)
  end

  def destroy?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator)
  end

  def permitted_attributes
    [:name, :description, :price, :franchise_id, :type, club_ids: []]
  end

end
