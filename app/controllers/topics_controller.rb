class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :find_topic, except: [:new, :create, :index]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    @topic.user = current_user

    if @topic.save
      flash[:notice] = "Topic created successfully"
      redirect_to @topic
    else
      flash[:error] = "There was an error creating the topic. Please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic successfully updated"
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the topic. Please try again"
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" successfully deleted."
      redirect_to user_mytopics_path(current_user.id)
    else
      flash[:error] = "There was an error deleting the Topic"
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title)
  end

  def find_topic
    @topic = Topic.find(params[:id])
    authorize @topic
  end
end
