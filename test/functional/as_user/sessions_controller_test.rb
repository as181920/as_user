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
    end
  end
end


