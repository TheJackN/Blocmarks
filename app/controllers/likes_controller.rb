class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_bookmark

  def create
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like

    if like.save
      flash[:notice] = "Bookmark Liked"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:error] = "There was an error liking bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    authorize like

    if like.destroy
      flash[:notice] = "Bookmark unliked"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:error] = "There was an error unliking bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    end
  end

  private
  def load_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end
end
