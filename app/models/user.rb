class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :buff, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_diaries, through: :likes, source: :diary

  validates :name, presence: true, length: { maximum: 255 }

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def create_buff
    buff = Buff.new(user_id: id)
    random_buff = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 500, 1000, 10000].sample
    buff.sum_buff = random_buff
    buff.save!
  end

  def login_buff
    buff = Buff.find_by!(user_id: id)
    random_buff = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 500, 1000, 10000].sample
    buff.sum_buff = random_buff
    buff.save!
  end

  def guest_buff
    buff = Buff.find_or_create_by!(user_id: id)
    random_buff = [10, 20, 30].sample
    buff.sum_buff = random_buff
    buff.save!
  end

  # def create_like(diary)
  #   like = Like.new(user_id: id, diary_id: diary.id)
  #   like.count += buff.sum_buff
  #   like.save!
  # end

  def like(diary)
    like = Like.find_or_create_by!(user_id: id, diary_id: diary.id)
    like.count += buff.sum_buff
    like.save!
  end
end
