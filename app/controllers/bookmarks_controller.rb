class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :load_bookmark, except: [:new, :create]
  after_action :verify_authorized, except: [:show]

  def show
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark successfully created"
      render :show
    else
      flash[:error] = "There was an error creating the bookmark"
      render :new
    end
  end

  def edit
  end

  def update
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark successfully updated"
      render :show
    else
      flash[:error] = "There was an error updating the bookmark"
      render :edit
    end
  end

  def destroy
    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" bookmark was successfully deleted"
      redirect_to @bookmark.topic
    else
      flash[:error] = "There was an error deleting the bookmark"
      render :show
    end
  end

  private
  def load_bookmark
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
