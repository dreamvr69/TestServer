class Ember::ServicesController < Ember::BaseController
  before_action :authenticate_user!
end
