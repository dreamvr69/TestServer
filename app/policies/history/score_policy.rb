class History::ScorePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator) || user.has_role?(:score_manager)
  end

  def permitted_attributes
    [:type, :score, :comment, :client_id, :manager_id]
  end

  class Scope < Scope
    def resolve
      if user.has_role? :franchise_administrator
        scope.where(club.in user.franchise.clubs)
      else
        scope.where(club: user.selected_club)
      end
    end
  end

end
