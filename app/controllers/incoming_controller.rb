class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    # You put the message-splitting and business
    # magic here.

    @user = User.where(email: params[:sender])
    @topic = Topic.where(title: params[:subject])
    bookmark_url = params["body-plain"]

    if @user.nil?
      # generated_password = Devise.friendly_token.first(8)
      # @user = User.create!(:email => params[:sender], :password => generated_password)
      # # @user.save
      #
      # # RegistrationMailer.welcome(@user, generated_password).deliver
      break
    end

    if @topic.nil?
      @topic = Topic.create!(:user => @user, :title => params[:subject])
      @topic.save
    end

    @bookmark = @topic.bookmarks.build(url: bookmark_url)
    @bookmark.save

    # Assuming all went well.
    head 200
  end
end
