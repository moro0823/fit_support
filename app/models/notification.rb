class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  #新着メッセージから表示する
  belongs_to :room
  belongs_to :chat
  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id'
  #visitor_id : 通知を送ったユーザーのid
  #visited_id : 通知を送られたユーザーのid
end
