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

  factory :admin_post, class: AdminPost do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 30) }
    youtube_url { Faker::Lorem.characters(number: 8) }
    is_show { "未公開" }
  end

  factory :true_admin_post, class: AdminPost do
    title { Faker::Lorem.characters(number: 9) }
    body { Faker::Lorem.characters(number: 29) }
    youtube_url { Faker::Lorem.characters(number: 8) }
    is_show { "公開中" }
  end
end
