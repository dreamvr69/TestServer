class LoyaltyPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def update?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator)
  end

  def permitted_attributes
    [:score]
  end

end
