class Mobile::ProjectsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    include CrudActionsMixin
    self.responder = ApplicationResponder
    respond_to  :json

    def namespace
      'Mobile::'
    end

end
