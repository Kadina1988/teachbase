FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { 'ramazan' }
    password_confirmation { 'ramazan' }
  end
end
