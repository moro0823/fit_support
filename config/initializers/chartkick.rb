# sqliteがtimezoneのサポートがない為
if Rails.env.development?
  Groupdate.time_zone = false
end

#本番環境では折れ線グラフの時間が東京時間で表示(chartkickを使用しているため)
if Rails.env.production?
  Groupdate.time_zone = "Asia/Tokyo"
end