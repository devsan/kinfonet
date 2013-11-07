FactoryGirl.define do
  factory :user do
    sequence(:name)    { |n| "Person #{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com" }
    password "secret"
  end

  factory :classified do
    name "Hello Bristol"
    content "Lorem ipsum"
    user
  end
end