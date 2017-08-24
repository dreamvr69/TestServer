class ProjectPolicy < ApplicationPolicy
  def index?
    false
  end

  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @post = post
  end
end
