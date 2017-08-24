class CoachPolicy < ApplicationPolicy

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
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:workout_writer)
  end

  def destroy?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:workout_writer)
  end

  def permitted_attributes
    [:name, :share_url, :conducting_personal, :conducting_group, :club_id, :image, :remove_image, training_package_ids: []]
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
