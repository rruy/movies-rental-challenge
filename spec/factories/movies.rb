require 'faker'

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    available_copies { 3 }

    # Other attributes and associations can be defined here
  end
end
