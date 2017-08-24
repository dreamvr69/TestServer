class Ember::ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :phone, :address, :website_link, :franchise_id, :user_ids, :coach_ids,
             :news_ids, :club_shedule_id, :card_template_ids, :vk_link, :twitter_link,
             :facebook_link, :instagram_link, :club_image_ids, :first_level_min_score,
             :second_level_min_score, :max_score_per_day,
             :vk_share_score,
             :twitter_share_score,
             :facebook_share_score,
             :instagram_share_score,
             :vk_share_per_day,
             :twitter_share_per_day,
             :facebook_share_per_day,
             :instagram_share_per_day,
             :third_level_min_score, :fourth_level_min_score, :fifth_level_min_score, :service_ids

  def club_shedule_id
    @object.club_shedule.id
  end
end
