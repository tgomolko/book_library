FactoryBot.define do
  factory :plan do
    nickname { "Standard" }
    product_id { 1 }
    currency { "usd" }
    interval { "week" }
  end

  factory :user do
    name { "Joe" }
    email { "joe@elearning.com" }
    password { "blah2322" }

    factory :admin_user do
      role { "admin" }
    end
  end

  factory :product do
    name { "Book Library" }
    product_type { "service" }
  end
end
