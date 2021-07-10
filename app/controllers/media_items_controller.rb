# frozen_string_literal: true

class MediaItemsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, only: %i[index_trip index_waypoint new_trip new_waypoint]
  before_action :set_waypoint, only: %i[index_waypoint new_waypoint]
  before_action :set_media_item, only: %i[show edit update destroy like dislike]
  authorize_resource

  def index_public
    @pagy, @media_items = pagy(MediaItem.most_popular_public, items: 24)
  end

  def index_trip
    @pagy, @media_items = pagy(@trip.media_items.order(id: :desc), items: 24)
  end

  def index_waypoint
    @pagy, @media_items = pagy(@waypoint.media_items.order(id: :desc), items: 24)
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
    @trip = @media_item.trip
  end

  def show
  end

  def create
    @media_item = MediaItem.create(media_item_params)
    @media_item.user = current_user

    respond_to do |format|
      if @media_item.save
        Activity.create(user: current_user, subject: @media_item, action: "uploaded")
        format.html { redirect_to @media_item, notice: "Media item was successfully created." }
      else
        format.html { redirect_back fallback_location: @trip, alert: error_string("create") }
      end
    end
  end

  def update
    respond_to do |format|
      if @media_item.update(media_item_params)
        format.html { redirect_to @media_item, notice: "Media item was successfully updated." }
      else
        format.html { redirect_back fallback_location: @media_item, alert: error_string("update") }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @media_item.destroy
        format.html { redirect_to trip_media_items_path(@trip), notice: "Media item was successfully deleted." }
      else
        format.html { redirect_back fallback_location: trip_media_items_path(@trip), alert: "Media item could not be deleted." }
      end
    end
  end

  def like
    @media_item.like current_user
    set_media_item
  end

  def dislike
    @media_item.dislike current_user
    set_media_item
  end

  private
    def media_item_params
      params.require(:media_item).permit(%i[title description waypoint_id photo])
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_waypoint
      @waypoint = Waypoint.find(params[:waypoint_id])
    end

    def set_media_item
      @media_item = MediaItem.find(params[:id])
      @waypoint = @media_item.waypoint
      @trip = @waypoint.trip
    end

    def error_string(action)
      "Could not #{action} media item. Errors:<br>- #{@media_item.errors.full_messages.join('<br>- ')}"
    end
end
