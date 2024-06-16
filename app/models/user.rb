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

  def buff
    Buff.find_or_create_by!(user_id: id) do |buff|
      random_buff = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100].sample
      buff.sum_buff = random_buff
    end
  end

  def guest_buff
    Buff.find_or_create_by!(user_id: id)
  end

  def create_like(diary)
    like = Like.new(user_id: id, diary_id: diary.id)
    like.count += buff.sum_buff
    like.save!
  end

  def update_like(like_id)
    like = Like.find_by(id: like_id)
    like.count += buff.sum_buff
    puts "更新された値は#{like.count}"
    like.save!
  end
end
