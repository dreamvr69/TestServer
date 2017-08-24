require './lib/application_responder'

class Ember::BaseController < ActionController::API
  include CrudActionsMixin
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_user_from_token

  self.responder = ApplicationResponder

  respond_to  :json
  attr_reader :current_user

  protected
    def namespace
      'Ember::'
    end

    def authenticate_user_from_token
      authenticated = authenticate_with_http_token do |user_token, options|
        id = options[:id].presence
        user = User.find id

        puts 'USER'
        puts user

        if user && Devise.secure_compare(user.authentication_token, user_token)
          puts 'SUCCESS'
          @current_user = user
        else
          return false
        end
      end
      authenticated.nil? ? false : authenticated
    end

    def authenticate_user!
      if @current_user.nil?
        raise Warden::NotAuthenticated
      else
        @current_user
      end
    end
end
