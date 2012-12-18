require_dependency "as_user/application_controller"

module AsUser
  class SessionsController < ApplicationController
    def new
      if signed_in? then
        redirect_to current_user
      end
    end

    def create
      user = User.find_by_email params[:session][:email].downcase
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_to user
        #redirect_to (session[:original_url] || current_user)
        #session[:original_url] = nil
      else
        flash.now[:error] = "Invalid email/password combination"
        render 'new'
      end
    end

    def destroy
    end
  
  end
end


