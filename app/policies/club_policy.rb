class ClubPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:franchise_administrator)
  end

  def update?
    user.has_role?(:club_administrator) || user.has_role?(:franchise_administrator) ||
    user.has_role?(:club_writer)
  end

  def destroy?
    user.has_role?(:franchise_administrator)
  end

  def show_in_main_menu?
    user.has_role?(:franchise_administrator) || user.has_role?(:club_administrator) ||
    user.has_role?(:club_reader) || user.has_role?(:club_writer)
  end

  def permitted_attributes
    [:name, :description, :phone, :address, :website_link,
     :franchise_id, :user_ids, :vk_link, :twitter_link, :facebook_link, :first_level_min_score,
     :second_level_min_score, :max_score_per_day,
     :third_level_min_score, :fourth_level_min_score, :fifth_level_min_score,
     :vk_share_score,
     :twitter_share_score,
     :facebook_share_score,
     :instagram_share_score,
     :vk_share_per_day,
     :twitter_share_per_day,
     :facebook_share_per_day,
     :instagram_share_per_day,
     :instagram_link,
     service_ids: []]
  end

  class Scope < Scope
    def resolve
      if user.has_role? :fitclubs_administrator
        scope
      else
        if user.has_role? :franchise_administrator
          scope.where(franchise: user.franchise)
        else
          scope.where(id: user.selected_club)
        end
      end
    end
  end

end
