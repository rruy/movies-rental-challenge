require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # Additional attributes and associations can be defined here
  end
end
