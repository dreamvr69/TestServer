class EventsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    self.responder = ApplicationResponder

    respond_to  :json

  def index
    client = Mongo::Client.new('mongodb://127.0.0.1:27017/local')
    @events = client[:events].find()
    # respond_to do |format|
    #
    #   format.html {render 'index'}
    #   format.json {render json: @events}
    #
    # end
    render json: @events.to_json(:only => [:_id as id ,:name, :begin, :end], :root => true), :root => false
  end

  def create
    puts 'gsdg'
    #Comment.create(:body => params[:body], :title => params[:title], :manager_name => params[:manager_name])
    puts params
    client = Mongo::Client.new('mongodb://127.0.0.1:27017/local')
    result = client[:events].insert_one(params)
    #
    puts result
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
end
