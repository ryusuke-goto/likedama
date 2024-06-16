class Like < ApplicationRecord
    belongs_to :user
    belongs_to :diary

    def self.likes_count(id)
      likes = Like.where(diary_id: id)
      total_count = likes.map(&:count).sum
    end
    
    def self.record_find(user:, diary:)
      Like.find_by(user_id: user, diary_id: diary)
    end
end
