require 'ffaker'

FactoryGirl.define do
  factory :user do
    email FFaker::Internet.email
    password 'fake_password'
    encrypted_password 'fake_password'
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
  end

  factory :organization do
    title FFaker::Name.name
    user
  end

end