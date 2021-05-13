FactoryBot.define do
  factory :post, class: Post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 30) }
    status { "トレーニングメニュー" }
  end

  factory :eat_post, class: Post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 30) }
    status { "食事" }
  end

  factory :info_post, class: Post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 30) }
    status { "情報の共有" }
  end

end