class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.where(email: params[:sender]).first
    @topic = Topic.find_by(title: params[:subject])
    bookmark_url = params["body-plain"]

    if @user.nil?
      break
    elsif @topic.nil?
      @topic = Topic.create!(:user => @user, :title => params[:subject])
      @topic.save
      @bookmark = @topic.bookmarks.build(url: bookmark_url)
      @bookmark.user = @user
      @bookmark.save
    else
      @bookmark = @topic.bookmarks.build(url: bookmark_url)
      @bookmark.user = @user
      @bookmark.save
    end

    head 200
  end
end
