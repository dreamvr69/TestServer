class Ember::QrsController < Ember::BaseController
  before_action :authenticate_user!
end
