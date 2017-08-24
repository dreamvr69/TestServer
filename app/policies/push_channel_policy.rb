class PushChannelPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:push_administrator)
  end

  def update?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:push_administrator)
  end

  def destroy?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:push_administrator)
  end

  def permitted_attributes
    [:name, :description, :franchise_id, :club_id, user_ids: []]
  end

  class Scope < Scope
    def resolve
      if user.has_role? :fitclubs_administrator
        scope
      else
        if user.has_role? :franchise_administrator
          scope.where(franchise: user.franchise)
        else
          scope.where(club: user.selected_club)
        end
      end
    end
  end

end
