require_dependency "as_user/application_controller"

module AsUser
  class AboutsController < ApplicationController
    # GET /users
    # GET /users.json
    def index
      flash[:notice] = "Welcome"
    end
  end
end
