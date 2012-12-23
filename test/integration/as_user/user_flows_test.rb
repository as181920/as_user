require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  test "home page" do
    get "/as_user"
    assert_select "a[href=?]",'/as_user/signin', 1
    assert_select "a[href=?]",'/as_user/signup', 1
  end

  test "signup and edit" do
    #signup
    get "/as_user/users/new"
    assert_select "form"
    assert_select "#user_email"
    assert_select "[name=?]","utf8"
    assert_select "[name=?]", "user[email]"
    assert_select "[name=?]", "user[password]"
    assert_select "[name=?]", "user[password_confirmation]"
    assert_response :success
    assert_select "a[href=?]","/as_user/signin", {count: 1, text: "Signin"}

    post_via_redirect "/as_user/users", user: {email: "dummy@example.com", name: "dummy", password: "dummy", password_confirmation: "dummy"}
    user_id = path.split("/")[3]
    assert_equal "/as_user/users/#{user_id}", path
    assert_equal "User was successfully created.", flash[:notice]
    assert_select "a[href=?]","/as_user/users/#{user_id}/edit", {count: 1, text: "Edit"}
    assert_select "a[href=?][data-method=?]","/as_user/signout", "delete", {count: 1, text: "Signout"}

    #edit
    get "/as_user/users/#{user_id}/edit"
    assert_select "form"
    assert_select "[name=?]", "user[email]"
    assert_select "[name=?]", "user[name]"
    assert_select "[name=?]", "user[password]",false
    assert_select "[name=?]", "user[password_confirmation]",false
    assert_select "a[href=?]","/as_user/users/#{user_id}", {count: 1, text: "Cancel"}

    put_via_redirect "/as_user/users/#{user_id}", {id: user_id, user: { email: "email#{Time.now.to_f}@example.com", name: "name" }}
    assert_equal "/as_user/users/#{user_id}", path
    assert_equal 'User was successfully updated.', flash[:notice]
    get path # need get here, do not need do this on web browser
    assert_select "a[href=?]","/as_user/users/#{user_id}/edit", {count: 1, text: "Edit"}
    assert_select "a[href=?][data-method=?]","/as_user/signout", "delete", {count: 1, text: "Signout"}

    get "/as_user/users/#{user_id}/edit_password"
    assert_select "form"
    assert_select "[name=?]", "user[email]",false
    assert_select "[name=?]", "user[name]",false
    assert_select "[name=?]", "user[password]"
    assert_select "[name=?]", "user[password_confirmation]"
    assert_select "a[href=?]","/as_user/users/#{user_id}", {count: 1, text: "Cancel"}
    put_via_redirect "/as_user/users/#{user_id}", {id: user_id, user: { password: "pwd1234", password_confirmation: "pwd1234" }}
    assert_equal "/as_user/users/#{user_id}", path
    assert_equal 'User was successfully updated.', flash[:notice]
  end

  test "signin and redirected back and signout" do
    @user = create_dummy_user

    #signin
    get "/as_user/signin"
    assert_response :success
    assert_select "[name=?]", "session[email]"
    assert_select "[name=?]", "user[email]", 0
    assert_select "[name=?]", "session[password]"
    assert_select "[name=?]", "session[password_confirmation]", 0
    assert_select "a[href=?]",'/as_user/signup', 1

    ## goto some page first
    origin_path = "/as_user/users/#{@user.id}/edit"
    get origin_path
    assert_response :redirect
    get_via_redirect origin_path
    assert_equal "/as_user/signin", path

    post_via_redirect "/as_user/sessions", session: {email: @user.email, password: "dummy"}
    assert_equal origin_path, path

    get_via_redirect "/as_user/signin"
    assert_equal "/as_user/users/#{@user.id}", path

    #signout
    delete_via_redirect "/as_user/signout"
    assert_equal "/as_user/", path
  end

  test "view my info page" do
    @user1 = create_dummy_user
    @user2 = create_dummy_user
    user1_id = @user1.id
    user2_id = @user2.id
    
    get_via_redirect "/as_user/users/#{user1_id}"
    assert_equal "/as_user/users/#{user1_id}", path
    assert_select "a[href=?]","/as_user/users/#{user1_id}/edit", 0
    assert_select "a[href=?][data-method=?]","/as_user/signout", "delete", 0

    post_via_redirect "/as_user/sessions", session: {email: @user2.email, password: "dummy"}
    get_via_redirect "/as_user/users/#{user1_id}"
    assert_equal "/as_user/users/#{user1_id}", path
    assert_select "a[href=?]","/as_user/users/#{user1_id}/edit", 0
    assert_select "a[href=?][data-method=?]","/as_user/signout", "delete", 0

    get_via_redirect "/as_user/users/#{user2_id}"
    assert_equal "/as_user/users/#{user2_id}", path
    assert_select "a[href=?]","/as_user/users/#{user2_id}/edit", {count: 1, text: "Edit"}
    assert_select "a[href=?][data-method=?]","/as_user/signout", "delete", {count: 1, text: "Signout"}
  end

  private
  def create_dummy_user
    email = "dummy#{Time.now.to_f}@example.com"
    user = User.create!(email: email, name: "dummy", password: "dummy",password_confirmation: "dummy")
  end
end
      # test links
