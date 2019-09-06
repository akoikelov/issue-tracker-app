require 'ffaker'

FactoryGirl.define do
  factory :organization do
    title FFaker::Name.name
    user
  end

  factory :role do
    title FFaker::String::WORD_CHARS
    organization
  end

  factory :invite do
    email FFaker::Internet.email
    organization
    role
  end
end