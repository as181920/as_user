require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "create user and browe home and finally signout and signin again" do
    #get new_user_path
    get "/as_user/users/new"
    assert_response :success

    post_via_redirect "/as_user/users", user: {email: "dummy@example.com", name: "dummy", password: "dummy", password_confirmation: "dummy"}
    loged_in_path = path
    assert path =~ /as_user\/users\/\d+/
    assert_equal "User was successfully created.", flash[:notice]

    get "/as_user"
    assert_response :success

    get_via_redirect "/as_user/signin"
    assert_equal loged_in_path, path

    delete_via_redirect "/as_user/signout"
    assert_equal "/as_user/", path
    get_via_redirect "/as_user/signin"
    assert_equal "/as_user/signin", path

    post_via_redirect "/as_user/sessions", session: {email: "dummy", password: "dummy"}
    assert_template :new
    assert_equal "Invalid email/password combination", flash[:error]
    post_via_redirect "/as_user/sessions", session: {email: "dummy@example.com", password: "dummy"}
    assert_equal loged_in_path, path

    get_via_redirect "/as_user/signin"
    assert_equal loged_in_path, path
  end
end
