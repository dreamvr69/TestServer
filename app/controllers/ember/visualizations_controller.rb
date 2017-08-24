class Ember::VisualizationsController < ApplicationController
  before_action :authenticate

  skip_before_filter :verify_authenticity_token
  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  def namespace
    'Ember::'
  end

  def create
    visualization = Visualization.new(params.permit(:data, :vr_data, :room, :begin, :end))

    @current_user.quick_save_id = visualization.id
    @current_user.save

    visualization.save

    render :nothing => true
  end

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(authentication_token: token)
    end
  end

end
