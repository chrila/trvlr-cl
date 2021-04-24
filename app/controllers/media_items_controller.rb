class MediaItemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_trip, only: %i[index_trip new_trip new_waypoint]
  before_action :set_waypoint, only: %i[index_waypoint new_waypoint]
  before_action :set_media_item, only: %i[show edit update destroy like dislike]

  def index
    @media_items = MediaItem.all.order(:id).reverse
  end

  def index_trip
    @media_items = MediaItem.for_trip(@trip).order(:id).reverse
  end

  def index_waypoint
    @media_items = MediaItem.for_waypoint(@waypoint).order(:id).reverse
  end

  def new
    @media_item = MediaItem.new
    @media_item.waypoint = @waypoint
  end

  def new_trip
    @media_item = MediaItem.new
    render :new
  end

  def new_waypoint
    @media_item = MediaItem.new
    @media_item.waypoint = @waypoint
    render :new
  end

  def edit
  end

  def show
  end

  def create
    @media_item = MediaItem.create(media_item_params)
    @media_item.user = current_user

    respond_to do |format|
      if @media_item.save
        Activity.create(user: current_user, description: "Uploaded a new media item from #{@media_item.waypoint.name}, #{@media_item.waypoint.country}.")
        format.html { redirect_to @media_item, notice: 'Media item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @media_item.update(media_item_params)
        format.html { redirect_to @media_item, notice: 'Media item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @media_item.destroy
        format.html { redirect_to :back, notice: 'Media item was successfully deleted.' }
      else
        format.html { redirect_to :back, alert: 'Media item could not be deleted.' }
      end
    end
  end

  def like
    Like.like(current_user, @media_item)
  end

  def dislike
    Like.dislike(current_user, @media_item)
  end

  private

  def media_item_params
    params.require(:media_item).permit(%i[title description waypoint_id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_waypoint
    @waypoint = Waypoint.find(params[:waypoint_id])
  end

  def set_media_item
    @media_item = MediaItem.find(params[:id])
  end
end
