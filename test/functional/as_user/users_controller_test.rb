require 'test_helper'

module AsUser
  class UsersControllerTest < ActionController::TestCase
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
  
    #TODO: permission
    test "should get edit" do
      @user = FactoryGirl.create(:user)
      get :edit, id: @user
      assert_response :success
      assert_not_nil assigns(:user)
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
  
      assert_redirected_to user_path(assigns(:user))
    end

    test "create invalid user with error message" do
      assert_no_difference('User.count') do
        post :create, user: { email: "a", name: "dummy", password: "dummy", password_confirmation: "dummy" }
      end
      assert_equal "create user failed.", flash[:error]
    end
  
    #TODO update user
    #test "should update user" do
    #  user = FactoryGirl.create(:user)
    #  put :update, id: user, user: { email: "x@x.com", name: "xx" }
    #  assert_redirected_to user_path(assigns(:user))
    #end
  
    test "should destroy user" do
      @user = FactoryGirl.create(:user)
      assert_difference('User.count', -1) do
        delete :destroy, id: @user
      end
  
      assert_redirected_to users_path
    end
  end
end
