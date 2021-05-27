class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, only: %i[index_trip index_waypoint new_trip new_waypoint]
  before_action :set_waypoint, only: %i[index_waypoint new_waypoint]
  before_action :set_post, only: %i[show edit update destroy like dislike]
  authorize_resource

  def index_public
    @pagy, @posts = pagy(Post.most_popular_public)
  end

  def index_trip
    @pagy, @posts = pagy(@trip.posts.order(id: :desc))
  end

  def index_waypoint
    @pagy, @posts = pagy(@waypoint.posts.order(id: :desc))
  end

  def new
    @post = Post.new
    @post.waypoint = @waypoint
  end

  def new_trip
    @post = Post.new
    render :new
  end

  def new_waypoint
    @post = Post.new
    @post.waypoint = @waypoint
    render :new
  end

  def edit
    @trip = @post.trip
  end

  def show
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        Activity.create(user: current_user, subject: @post, action: 'wrote')
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { redirect_back fallback_location: @trip, alert: error_string('create') }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { redirect_back fallback_location: @post, alert: error_string('update') }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to trip_posts_path(@trip), notice: 'Post was successfully deleted.' }
      else
        format.html { redirect_back fallback_location: trip_posts_path(@trip), alert: 'Post could not be deleted.' }
      end
    end
  end

  def like
    @post.like current_user
    set_post
  end

  def dislike
    @post.dislike current_user
    set_post
  end

  private

  def post_params
    params.require(:post).permit(%i[title content waypoint_id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_waypoint
    @waypoint = Waypoint.find(params[:waypoint_id])
  end

  def set_post
    @post = Post.find(params[:id])
    @waypoint = @post.waypoint
    @trip = @waypoint.trip
  end

  def error_string(action)
    "Could not #{action} post. Errors:<br>- #{@post.errors.full_messages.join('<br>- ')}"
  end
end
