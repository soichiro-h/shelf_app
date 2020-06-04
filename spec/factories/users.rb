FactoryBot.define do
  factory :user do
    nickname { "a" * 12 }
    email { "test3@example.com" }
    password { "psswrd" }
  end
end
