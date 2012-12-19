# encoding: utf-8
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@example.com"
    end
    sequence :name do |n|
      "name#{n}"
    end
    password "password"
    password_confirmation "password"
  end
end

