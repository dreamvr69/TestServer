class Ember::ProjectsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    include CrudActionsMixin
    self.responder = ApplicationResponder
    respond_to  :json


    before_action :authenticate

  # def index
  #   client = Mongo::Client.new('mongodb://127.0.0.1:27017/new_fitclubs_development')
  #   @items = client[:projects].find()
  #   #render json: (@events.as_json(:include=>:project_ids)).each {|el| el['id']=el['_id']}
  #   respond_with(@items,
  #                root: 'projects',
  #                each_serializer: serializer,
  #                serializer: PaginationSerializer)
  # end

  def index_user
    if @current_user.can_read_owned_by_user?(params[:user_id])
      @projects = Project.all user_id: params[:user_id]
      render json: (@projects.as_json()).each {|el| el['id']=el['_id']}
    else
      head 403
    end
  end

  def create
    #Comment.create(:body => params[:body], :title => params[:title], :manager_name => params[:manager_name])
    @current_user.projects.create(params.permit(:name, :begin, :end))
    #
    # if result == 1
    #   respond_to do |format|
    #
    #     format.html
    #     format.json {render :nothing => true}
    #
    #   end
    # else
    #   render 'new'
    # end
    render :nothing => true
  end

  def save
    project = Project.new(params[:project].permit(:event_name, :begin, :end, :client_name, :company_name))
    visualization = Visualization.new(params[:visualization].permit(:data, :vr_data, :room, :begin, :end))

    @current_user.quick_save_id = visualization.id
    @current_user.save

    project.visualizations << visualization
    @current_user.projects << project

    visualization.save

    render :nothing => true
  end

  def add_visualization
    visualization = Visualization.new(params.permit(:data, :vr_data, :room, :begin, :end))
    project = Project.find(params[:id])

    project.visualizations << visualization
    @current_user.quick_save_id = visualization.id
    @current_user.save

    puts visualization.save

    render :nothing => true
  end

  def namespace
    'Ember::'
  end

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(authentication_token: token)
    end
  end
end
