# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  name            :string(100)
#  password_digest :string(60)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  nickname        :string(100)
#

require 'test_helper'

module AsUser
  class UserTest < ActiveSupport::TestCase
    setup do
    end

    teardown do
      User.destroy_all
    end

    test "create new user" do
      user = FactoryGirl.create(:user)
      assert user.save
    end


    test "user with invalid email format" do
      user = User.new(email: "dummy#{Time.now.to_f}@domain", name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      user = User.new(email: "dummy", name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
    end

    test "user with duplicated email" do
      user = FactoryGirl.create(:user)
      assert user.save
      user = User.new(email: user.email, name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:email].include? "has already been taken"
    end

    test "user without email" do
      user = User.new(name: "dummy", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:email].include? "can't be blank"
    end

    test "user without name" do
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", password: "dummy",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:name].include? "can't be blank"
    end

    test "longest user name or too long" do
      # en
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "abcdeefghigabcdefghigabcdefghigabcdefghigabcdefghi", password: "dummy",password_confirmation: "dummy")
      assert user.save
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "abcddefghigabcdefghigabcdefghigabcdefghigabcdefghig", password: "dummy",password_confirmation: "dummy")
      assert !user.save

      # cn
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十", password: "dummy",password_confirmation: "dummy")
      assert user.save
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十零", password: "dummy",password_confirmation: "dummy")
      assert !user.save
    end

    test "user with duplicated name" do
      user = FactoryGirl.create(:user)
      assert user.save
      user = User.new(email: "x_#{Time.now.to_f}@x.com", name: user.name, password: "dummy",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:name].include? "has already been taken"
    end

    test "user with invalid password" do
      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "dummy", password: "du",password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:password].include? "is too short (minimum is 3 characters)"

      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "dummy", password_confirmation: "dummy")
      assert !user.save
      assert user.errors.messages[:password].include? "can't be blank"

      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "dummy", password: "dummy")
      assert !user.save
      assert user.errors.messages[:password_confirmation].include? "can't be blank"

      user = User.new(email: "dummy#{Time.now.to_f}@example.com", name: "dummy", password: "dummy",password_confirmation: "dummz")
      assert !user.save
      assert user.errors.messages[:password].include? "doesn't match confirmation"
    end

    test "authenticate user" do
      user = FactoryGirl.create(:user)
      user = User.find_by_email user.email
      assert user.respond_to?(:authenticate)

      assert user.authenticate "password"
      assert !user.authenticate("wrong password")
    end

    test "delete one user" do
      user = FactoryGirl.create(:user)
      assert user.destroy
      assert_equal 0,User.all.count
    end

  end
end

