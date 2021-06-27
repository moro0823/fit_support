class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  enum sex: { "男性": 0, "女性": 1 }
  validates :username, presence: true
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customer, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_customer, through: :followed, source: :follower # 自分をフォローしている人

  has_many :customer_rooms
  has_many :chats
  has_many :rooms, through: :customer_rooms
  has_many :admin_post_comments, dependent: :destroy
  has_many :my_fitness_places, dependent: :destroy
  has_many :personals, dependent: :destroy
  has_many :karutes, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  #active_notifications　=> 自分から送る通知
  #posssive_notifications => 相手から受け取る通知
  #紐付ける名前とクラス名が異なるため、明示的にクラス名とIDを指定して紐付け

  # ユーザーをフォローする
  def follow(customer_id)
    follower.create(followed_id: customer_id)
  end

  # ユーザーのフォローを外す
  def unfollow(customer_id)
    follower.find_by(followed_id: customer_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(customer)
    following_customer.include?(customer)
  end

  # すでにいいねしているかを確かめる
  def already_favorited?(post)
    favorites.exists?(post_id: post.id)
    #exists レコードの存在を確認
  end

  def recorded_by?(staff)
    karutes.where(staff_id: staff.id).exists?
  end

  scope :search, -> (search_params) do
    # search_paramsが空の場合以降の処理を行わない。
    return if search_params.blank?

    # 下記で定義した各条件式にフォームで入力された値を入れ検索を実行する
      sex_like(search_params[:sex]).
      age_from(search_params[:age_from]).
      age_to(search_params[:age_to]).
      height_from(search_params[:height_from]).
      height_to(search_params[:height_to]).
      weight_from(search_params[:weight_from]).
      weight_to(search_params[:weight_to]).
      fat_percentage_from(search_params[:fat_percentage_from]).
      fat_percentage_to(search_params[:fat_percentage_to])
  end

  # 引数に入る値はフォームで入力された値が入る
  # 性別が存在する場合、sexカラムから引数の値があるか検索する
  scope :sex_like, -> (sex) { where(sex: sex) if sex.present? }
  # 年齢が存在する場合、agetカラムで範囲検索する ↓詳細
    # ageカラムから引数で入力された値(from)以上の値があるか検索する
    # ageカラムから引数で入力された値(to)以下の値があるか検索する
  scope :age_from, -> (from) { where('? <= age', from) if from.present? }
  scope :age_to, -> (to) { where('age <= ?', to) if to.present? }
  # 身長が存在する場合、heightカラムで範囲検索する
  scope :height_from, -> (from) { where('? <= height', from) if from.present? }
  scope :height_to, -> (to) { where('height <= ?', to) if to.present? }
  # 体重が存在する場合、weightで範囲検索する
  scope :weight_from, -> (from) { where('? <= weight', from) if from.present? }
  scope :weight_to, -> (to) { where('weight <= ?', to) if to.present? }
  # 体脂肪率が存在する場合、fat_pasentageで範囲検索する
  scope :fat_percentage_from, -> (from) { where('? <= fat_percentage', from) if from.present? }
  scope :fat_percentage_to, -> (to) { where('fat_percentage <= ?', to) if to.present? }

  scope :search_friend, -> (search_friend_params) do
    return if search_friend_params.blank?
    username(search_friend_params[:username])
  end

  scope :search_admin_customer, -> (search_admin_customer_params) do
    return if search_admin_customer_params.blank?
    username(search_admin_customer_params[:username])
  end

  scope :username, -> (username) { where('username LIKE ?', "%#{username}%") if username.present? }

end
