FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Example Movie #{n}" }
    available_copies { 3 }

    #title { 'Example Movie' }
    # Other attributes and associations can be defined here
  end
end
