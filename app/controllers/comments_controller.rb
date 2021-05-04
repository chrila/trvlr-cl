class CommentsController < ApplicationController
  before_action :set_activity, only: %i[index_activity new_activity]
  before_action :set_media_item, only: %i[index_media_item new_media_item]
  before_action :set_post, only: %i[index_post new_post]
  before_action :set_trip, only: %i[index_trip new_trip]
  before_action :set_comment, only: %i[show edit update destroy like dislike]
  before_action :create_comment, only: %i[new_activity new_media_item new_post new_trip]
  authorize_resource

  def index
    @comments = Comment.all.order(id: :desc)
  end

  def index_activity
    @comments = @activity.comments.order(id: :desc)
    render :index
  end

  def index_media_item
    @comments = @media_item.comments.order(id: :desc)
    render :index
  end

  def index_post
    @comments = @post.comments.order(id: :desc)
    render :index
  end

  def index_trip
    @comments = @trip.comments.order(id: :desc)
    render :index
  end

  def new
  end

  def new_activity
    render :new
  end

  def new_media_item
    render :new
  end

  def new_post
    render :new
  end

  def new_trip
    render :new
  end

  def edit
  end

  def show
  end

  def create
    @comment = Comment.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        Activity.create(user: current_user, description: "commented on a #{@comment.commentable_type.downcase}.")
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @commentable, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @commentable = @comment.commentable
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @commentable, notice: 'Comment was successfully deleted.' }
      else
        format.html { redirect_to @commentable, alert: 'Comment could not be deleted.' }
      end
    end
  end

  def like
    Like.like(current_user, @comment)
    set_comment
  end

  def dislike
    Like.dislike(current_user, @comment)
    set_comment
  end

  private

  def comment_params
    params.require(:comment).permit(%i[title content commentable_type commentable_id])
  end

  def set_activity
    @activity = Activity.find(params[:id])
    @commentable = @activity
  end

  def set_media_item
    @media_item = MediaItem.find(params[:id])
    @commentable = @media_item
  end

  def set_post
    @post = Post.find(params[:id])
    @commentable = @post
  end

  def set_trip
    @trip = Trip.find(params[:id])
    @commentable = @trip
  end

  def create_comment
    @comment = @commentable.comments.build
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
