class Ember::UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token
  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  def namespace
    'Ember::'
  end

  #before_action :authenticate_user!, except: :authenticate
  before_action :authenticate_from_token, except: :authenticate

  # def authenticate
  #   user = User.find_by(email: params[:user][:email])
  #   if user.nil?
  #     head 404
  #   else
  #     if user.valid_password?(params[:user][:password])
  #       if user.has_role?(:client)
  #         head 401
  #       else
  #         if user.auth_date.nil?
  #           user.auth_date = DateTime.now
  #           user.save
  #         end
  #         data = {
  #             token: user.authentication_token,
  #             user_id: user.id.to_s,
  #             email: user.email
  #         }
  #         render json: data, status: :ok
  #       end
  #     else
  #       head 401
  #     end
  #   end
  # end

  def authenticate
    user = User.find_by(email: params[:user][:email])

    puts 'USER'
    puts user

    if user.nil?
      head 401
      return false
    else
      if user.valid_password?(params[:user][:password])
        puts 'VALID!!!'
              data = {
                  token: user.authentication_token,
                  user_id: user.id.to_s,
                  email: user.email
              }
              puts data
              render json: data, status: :ok
      else
        head 401
      end
    end

  end

  def quick_load
    respond_with(Visualization.find(@current_user.quick_save_id), serializer: 'Ember::VisualizationSerializer'.constantize, root: 'visualization')
  end

  protected
  def authenticate_from_token
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(authentication_token: token)
      return @current_user.id = params[:id]
    end
  end

end
