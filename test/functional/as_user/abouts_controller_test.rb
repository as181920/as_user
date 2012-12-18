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
    end
  end
end
