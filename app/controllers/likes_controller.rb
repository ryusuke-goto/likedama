class LikesController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @likes = current_user.create_like(@diary)
    puts "今のカウントはこれ！#{@likes.inspect}"
  end

  def update
    @likes = current_user.update_like(params[:id])
    puts "今のカウントはこれ！#{@likes.inspect}"
  end
end
