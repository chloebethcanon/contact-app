FactoryGirl.define do
  factory :contact do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |n| "johndoe#{n}@example.com"}
    phone_number "555-555-5555"
    sequence(:user_id) { |n| n }
  end
end