class Ember::NewsController < Ember::BaseController
  before_action :authenticate_user!
end
