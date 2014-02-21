FactoryGirl.define do
  factory :user do
    sequence(:fname)    { |n| "First #{n}" }
    sequence(:lname)    { |n| "Last #{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com" }
    password "secret"

    factory :admin do
      admin true
    end
  end

  factory :quote do
    phrase "Happy is the man who is nothing"
    content "Lorem ipsum"
    source_location "Ojai CA USA"
    source_detail "6th Public Talk 1946"
  end

  factory :classified do
    name "Hello Bristol"
    content "Lorem ipsum"
    user
  end
end