require 'test_helper'

module AsUser
  class UsersControllerTest < ActionController::TestCase
    include SessionsHelper
    setup do
    end

    teardown do
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end
  
    test "should show user" do
      @user = FactoryGirl.create(:user)
      get :show, id: @user
      assert_response :success
      assert_not_nil assigns(:user)
    end
  
    test "should get edit" do
      @user = FactoryGirl.create(:user)
      get :edit, id: @user
      assert_redirected_to root_path
      sign_in @user
      get :edit, id: @user
      assert_response :success
      assert_not_nil assigns(:user)
      assert_select "form"
      assert_select "[name=?]", "user[email]"
      assert_select "[name=?]", "user[name]"
      assert_select "[name=?]", "user[password]",false
      assert_select "[name=?]", "user[password_confirmation]",false
    end
  
    test "should get edit password" do
      @user = FactoryGirl.create(:user)
      get :edit_password, id: @user
      assert_redirected_to root_path
      sign_in @user
      get :edit_password, id: @user
      assert_response :success
      assert_not_nil assigns(:user)
      assert_select "form"
      assert_select "[name=?]", "user[email]",false
      assert_select "[name=?]", "user[name]",false
      assert_select "[name=?]", "user[password]"
      assert_select "[name=?]", "user[password_confirmation]"
    end
  
    test "should get new" do
      get :new
      assert_response :success
      assert_select "form"
      assert_select "#user_email"
      assert_select "[name=?]","utf8"
      assert_select "[name=?]", "user[email]"
      assert_select "[name=?]", "user[password]"
      assert_select "[name=?]", "user[password_confirmation]"
    end
  
    test "should create user" do
      assert_difference('User.count') do
        user = FactoryGirl.build(:user)
        post :create, user: { email: user.email, name: user.name, password: user.password, password_confirmation: user.password_confirmation }
      end
  
      assert_equal "User was successfully created.", flash[:notice]
      assert_redirected_to user_path(assigns(:user))
    end

    test "create invalid user with error message" do
      assert_no_difference('User.count') do
        post :create, user: { email: "a", name: "dummy", password: "dummy", password_confirmation: "dummy" }
      end
      assert_equal "create user failed.", flash[:error]
    end
  
    test "should update user" do
      # update user info
      @user = FactoryGirl.create(:user)
      put :update, {id: @user, user: { email: "email#{Time.now.to_f}@example.com", name: "name" }}
      assert_redirected_to root_path
      sign_in @user
      put :update, {id: @user, user: { email: "email#{Time.now.to_f}@example.com", name: "name" }}
      debugger
      assert_redirected_to @user
      assert_equal 'User was successfully updated.', flash[:notice]
      
      #assert_response :success

      #update user password
      #put :update, id: @user, user: { password: "pwd123", password_confirmation: "pwd123" }
      #assert @user.authenticate("pwd123"), "can not authenticate with new password."
      #assert_response :success
    end
  
    test "should destroy user" do
      @user_for_destroy = FactoryGirl.create(:user)
      @user_for_stay = FactoryGirl.create(:user)
      assert_no_difference('User.count') do
        delete :destroy, id: @user_for_destroy
      end
      sign_in @user_for_destroy
      assert_no_difference('User.count') do
        delete :destroy, id: @user_for_stay
      end
      assert_redirected_to root_path
      assert_difference('User.count', -1) do
        delete :destroy, id: @user_for_destroy
      end
  
      assert_redirected_to users_path
    end
  end
end
