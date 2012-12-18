module AsUser
  module SessionsHelper
    def sign_in(user)
      session[:user_id] = user.id
      self.current_user = user
    end

    def signed_in?
      #session[:original_url] = request.url
      !current_user.nil?
    end

    def sign_out
      #cookies.delete(:remember_token)
      session[:user_id] = nil
      self.current_user = nil
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      #@current_user ||= User.find_by_remember_token(cookies[:remember_token])
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def current_user?(user)
      user == current_user
    end
  end
end
