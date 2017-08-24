class TrainingPackagePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.clubs.include?(record.club) && user.has_role?(:club_administrator)) ||
    (user.franchise.clubs.include?(record.club) && user.has_role?(:franchise_administrator))
  end

  def create?
    user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator)
  end

  def update?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:workout_writer)
  end

  def destroy?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:workout_writer)
  end

  def permitted_attributes
    [:name, :training_count, :price, :club_id]
  end

  class Scope < Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(club: user.selected_club)
    end
  end

end
