# encoding: utf-8
require 'test_helper'

module AsUser
  class UserTest < ActiveSupport::TestCase
    setup do
    end

    teardown do
      User.destroy_all
    end

    test "only save valid user" do
      email = "dummy#{Time.now.to_f}@domain.com"
      user = User.new(email: email, name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert user.save

      # without name
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", password: "dummy",password_confirmation: "dummy")
      assert !user.save

      # name too long
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "abcdefghigabcdefghigabcdefghigabcdefghigabcdefghig", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "abcdefghigabcdefghigabcdefghigabcdefghigabcdefghi", password: "dummy",password_confirmation: "dummy")
      assert user.save

      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九", password: "dummy",password_confirmation: "dummy")
      assert user.save

      # email invalid
      user = User.new(email: "dummy#{Time.now.to_f}@domain", name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy", name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: email, name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:email].include? "has already been taken"

    # invalid password
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "dummy", password: "du",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "dummy", password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "dummy", password: "dummy")
      assert !user.save
      user = User.new(email: "dummy#{Time.now.to_f}@domain.com", name: "dummy", password: "dummy",password_confirmation: "dummz")
      assert !user.save
    end

    test "authenticate user" do
      create_dummy_user
      email = "dummy@domain.com"
      user = User.find_by_email email
      assert user.respond_to?(:authenticate)

      # invalid pasword for authentication
      assert user.authenticate "dummy"
      assert ! user.authenticate("dummz")
    end

    test "delete one user" do
      user = create_dummy_user
      assert user.destroy
      assert_equal 0,User.all.count
    end

    private
    def create_dummy_user
      email = "dummy@domain.com"
      user = User.create!(email: email, name: "dummy", password: "dummy",password_confirmation: "dummy")
    end

  end
end


