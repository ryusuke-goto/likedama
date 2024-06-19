class LikesController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @likes = current_user.like(@diary)
    @total_likes = Like.likes_count(params[:diary_id])
    puts "現在のカウント総数は!#{@total_likes}"
  end

#   def update
#     @diary = Diary.find(params[:diary_id])
#     @likes = current_user.update_like(params[:id])
#     @total_likes = Like.likes_count(params[:diary_id])
#     puts "アップデート後のカウント総数は!#{@total_likes}"
#     render turbo_stream: turbo_stream.replace("like-#{@diary.id}", partial: 'likes/like', {diary: @diary})
#   end
end
