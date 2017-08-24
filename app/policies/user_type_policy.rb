class UserTypePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator))
  end

  def create?
    (user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator))
  end

  def update?
    (user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator))
  end

  def destroy?
    (user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator))
  end

  def permitted_attributes
    [:name, :club_id, role_ids:[]]
  end

  class Scope < Scope
    def resolve
      unless user.has_role? :fitclubs_administrator
        UserType.where(club: user.selectedClub)
      end
    end
  end

end
