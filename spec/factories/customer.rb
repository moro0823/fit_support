FactoryBot.define do
  factory :customer, class: Customer do
    username { Faker::Lorem.characters(number: 10) }
    sequence(:email) { |n| "customer#{n}@example.com"}
    password {"password"}
    password_confirmation { 'password' }
    height { Faker::Lorem.characters(number: 3) }
    weight { Faker::Lorem.characters(number: 2) }
    fat_percentage { Faker::Lorem.characters(number: 3) }
    age { Faker::Lorem.characters(number: 2) }
    sex {"男性"}
  end

  factory :true_customer, class: Customer do
    username { Faker::Lorem.characters(number: 10) }
    sequence(:email) { |n| "true_customer#{n}@example.com"}
    password {"password"}
    password_confirmation { 'password' }
    height { Faker::Lorem.characters(number: 3) }
    weight { Faker::Lorem.characters(number: 2) }
    fat_percentage { Faker::Lorem.characters(number: 3) }
    age { Faker::Lorem.characters(number: 2) }
    is_show { true }
  end


  factory :admin_user,class: AdminUser do
    sequence(:email) { |n| "admin#{n}@example.com"}
    password {"adminpassword"}
  end

end