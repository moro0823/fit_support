FactoryBot.define do
  factory :post_comment, class: PostComment do
    comment { Faker::Lorem.characters(number: 10) }
  end

  factory :other_post_comment, class: PostComment do
    comment { Faker::Lorem.characters(number: 15) }
  end
end