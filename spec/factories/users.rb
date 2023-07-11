require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Name.first_name+"@domain.com" }
    username { Faker::Name.first_name.downcase }
    password { '123456@1' }
    password_confirmation { '123456@1' }
  end
end
