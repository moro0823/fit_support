FactoryBot.define do
  factory :customer, class: Customer do
    username {"morooka"}
    sequence(:email) { |n| "test#{n}@example.com"}
    password {"password"}
  end

  factory :another_customer,class: Customer do
    username {"test"}
    sequence(:email) { |n| "test#{n}@example.com"}
    password {"testpassword"}
  end

  factory :admin_user,class: AdminUser do
    sequence(:email) { |n| "admin#{n}@example.com"}
    password {"adminpassword"}
  end



end