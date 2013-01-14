# encoding: utf-8
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email_#{n}@example.com"
    end
    sequence :name do |n|
      "name_#{n}"
    end
    password "password"
    password_confirmation "password"
  end
end

