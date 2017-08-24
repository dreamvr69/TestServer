class Ember::LoyaltiesController < Ember::BaseController
  before_action :authenticate_user!
end
