FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
  end

  trait :with_files do
    after(:build) do |question|
      question.files.attach(
        io: File.open("#{Rails.root}/app/models/user.rb"),
        filename: 'user.rb'
      )
    end
  end
end
