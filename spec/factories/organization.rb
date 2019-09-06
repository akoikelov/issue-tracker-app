require 'ffaker'

FactoryGirl.define do
  factory :organization do
    title FFaker::Name.name
    user
  end
end