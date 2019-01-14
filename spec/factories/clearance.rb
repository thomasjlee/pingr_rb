FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user, aliases: [:pinger, :recipient] do
    email
    password { "password" }
  end
end
