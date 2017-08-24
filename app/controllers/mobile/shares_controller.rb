class Mobile::SharesController < Mobile::BaseController
  before_action :authenticate_user!

  swagger_controller :shares, 'Shares Management'

  swagger_api :create do
    summary 'Add score to users loyalty via social network name'
    param :header, 'Authorization', :string, :required, 'Authentication token'
    param :query, :type, :string, :required, 'Social name (vk, twitter, facebook, instagram)'
    response 200
    response 600, 'Too Much Use Today'
  end

  def create
    loyalty = @current_user.loyalty
    club = @current_user.selected_club
    user_shares_count = Share.where(user: @current_user,
                                    created_at: {gte: DateTime.now.utc.beginning_of_day,
                                                 lte: DateTime.now.utc.end_of_day},
                                    type: params[:type]).count
    case params[:type]
      when 'twitter'
        if user_shares_count == club.twitter_share_per_day
          head 600
        else
          Share.create(type: :twitter, user: @current_user, club: club)
          loyalty.score += club.twitter_share_score
          loyalty.save!
          head 200
        end
      when 'facebook'
        if user_shares_count == club.facebook_share_per_day
          head 600
        else
          Share.create(type: :facebook, user: @current_user, club: club)
          loyalty.score += club.facebook_share_score
          loyalty.save!
          head 200
        end
      when 'vk'
        if user_shares_count == club.vk_share_per_day
          head 600
        else
          Share.create(type: :vk, user: @current_user, club: club)
          loyalty.score += club.vk_share_score
          loyalty.save!
          head 200
        end
      when 'instagram'
        if user_shares_count == club.instagram_share_per_day
          head 600
        else
          Share.create(type: :instagram, user: @current_user, club: club)
          loyalty.score += club.instagram_share_score
          loyalty.save!
          head 200
        end
      else
        head 500
    end
  end

end
