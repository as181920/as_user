require 'test_helper'

module AsUser
  class SessionsControllerTest < ActionController::TestCase
    include SessionsHelper

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
    end

    test "sign in then sign out using name" do
    end

    test "sign in then sign out using email" do
      user = FactoryGirl.create(:user)
      response = post :create, session: {email: user.email, password: user.password}
      assert_equal 302, response.status
      assert session[:user_id]
      assert current_user

      response = delete :destroy
      assert_equal 302, response.status
      assert_nil session[:user_id]
      assert_nil current_user
      assert_equal "signed out.", flash[:notice]
    end

    test "sign in with invalid user" do
      post :create, session: {email: "a", password: "xxx"}
      assert_template :new
      assert_nil current_user
      assert_equal "Invalid name(or email)/password combination", flash[:error]
    end

  end
end

