class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, only: %i[index_trip index_waypoint new_trip new_waypoint]
  before_action :set_waypoint, only: %i[index_waypoint new_waypoint]
  before_action :set_post, only: %i[show edit update destroy like dislike]
  authorize_resource

  def index
    @pagy, @posts = pagy(Post.all.order(id: :desc))
  end

  def index_trip
    @pagy, @posts = pagy(Post.for_trip(@trip).order(id: :desc))
  end

  def index_waypoint
    @pagy, @posts = pagy(Post.for_waypoint(@waypoint).order(id: :desc))
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
  end

  def show
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        Activity.create(user: current_user, description: "Wrote a new blog post about #{@post.waypoint.name}, #{@post.waypoint.country}.")
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to :back, notice: 'Post was successfully deleted.' }
      else
        format.html { redirect_to :back, alert: 'Post could not be deleted.' }
      end
    end
  end

  def like
    Like.like(current_user, @post)
    set_post
  end

  def dislike
    Like.dislike(current_user, @post)
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
  end
end
