class ClientDevisePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def permitted_attributes
    [:user_id, :token, :os_type]
  end

end
