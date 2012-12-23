require 'test_helper'

module AsUser
  class SessionsControllerTest < ActionController::TestCase
    setup do
    end

    teardown do
    end
  
    test "should get new" do
      get :new
      assert_response :success
      assert_select "form"
      assert_select "[name=?]","utf8"
      assert_select "[name=?]","commit"
      assert_select "[name=?]","user[email]",false
      assert_select "[name=?]","session[email]"
      assert_select "[name=?]","session[password]"
      # test links
      assert_select "a[href=?]",'/as_user/signup', 1
    end

    test "sign in then sign out" do
      user = FactoryGirl.create(:user)
      post :create, session: {email: user.email, password: user.password}
      assert_redirected_to user

      delete :destroy
      assert_nil session[:user_id]
      assert_redirected_to root_path
      assert_equal "signed out.", flash[:notice]
    end

    test "sign in with invalid user" do
      post :create, session: {email: "a", password: "xxx"}
      assert_template :new
      assert_equal "Invalid email/password combination", flash[:error]
    end

  end
end

