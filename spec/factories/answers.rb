FactoryBot.define do
  factory :answer do
    body { "MyString" }
    question { nil }
  end

  trait :invalid_ans do
    body { nil }
  end
end
