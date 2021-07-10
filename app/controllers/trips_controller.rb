# frozen_string_literal: true

class TripsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, only: %i[show edit update destroy like dislike set_cover_photo]
  authorize_resource

  def index
    @pagy, @trips = pagy(current_user.trips.order(id: :desc))
  end

  def index_public
    @pagy, @trips = pagy(Trip.most_popular_public)
  end

  def new
    @trip = Trip.new
  end

  def edit
  end

  def show
  end

  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        @trip.trip_users.create(user: current_user, role: TripUser.roles["role_administrator"])
        Activity.create(user: current_user, subject: @trip)

        format.html { redirect_to @trip, notice: "Trip was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: "Trip was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @trip.destroy
        format.html { redirect_to trips_path, notice: "Trip was successfully deleted." }
      else
        format.html { redirect_to trips_path, alert: "Trip could not be deleted." }
      end
    end
  end

  def like
    @trip.like current_user
    set_trip
  end

  def dislike
    @trip.dislike current_user
    set_trip
  end

  def set_cover_photo
    media_item = MediaItem.find(params[:media_item_id])
    return unless media_item

    respond_to do |format|
      if @trip.update(cover_photo: media_item)
        format.html { redirect_to media_item, notice: "Cover photo successfully updated." }
      else
        format.html { redirect_to media_item, alert: "Could not set cover photo." }
      end
    end
  end

  private
    def trip_params
      params.require(:trip).permit(%i[title description start_date end_date budget visibility status])
    end

    def set_trip
      @trip = Trip.find(params[:id] || params[:trip_id])
    end
end
