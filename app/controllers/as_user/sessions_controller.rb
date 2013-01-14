require_dependency "as_user/application_controller"

module AsUser
  class SessionsController < ApplicationController
    def new
      if signed_in? then
        redirect_to current_user
      end
    end

    def create
      user = User.find_by_name(params[:session][:name]) || User.find_by_email(params[:session][:email].to_s.downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or main_app.root_path
      else
        flash.now[:error] = "Invalid name(or email)/password combination"
        render 'new'
      end
    end

    def destroy
      store_location
      sign_out
      flash[:notice] = "signed out."
      #redirect_back_or main_app.root_path
      redirect_to main_app.root_path
    end
  
  end
end


