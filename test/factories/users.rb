# encoding: utf-8
FactoryGirl.define do
  factory :user do
    email 'dummy1@domain.com'
    name 'dummy'
    password "password"
    password_confirmation "password"
  end
end

