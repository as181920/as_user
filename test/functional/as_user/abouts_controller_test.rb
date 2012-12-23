require 'test_helper'

module AsUser
  class AboutsControllerTest < ActionController::TestCase
    setup do
    end

    teardown do
    end
  
    test "should get index" do
      get :index
      assert_response :success
      # test links
      assert_select "a[href=?]",'/as_user/signin', 1
      assert_select "a[href=?]",'/as_user/signup', 1
    end
  end
end

