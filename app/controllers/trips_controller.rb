class TripsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, only: %i[show edit update destroy like dislike]
  authorize_resource

  def index
    @pagy, @trips = pagy(Trip.of_user(current_user).order(id: :desc))
  end

  def new
    @trip = Trip.new
  end

  def edit; end

  def show; end

  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        @trip.trip_users.create(user: current_user, role: TripUser.roles['role_administrator'])
        Activity.create(user: current_user, subject: @trip)

        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @trip.destroy
        format.html { redirect_to trips_path, notice: 'Trip was successfully deleted.' }
      else
        format.html { redirect_to trips_path, alert: 'Trip could not be deleted.' }
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

  private

  def trip_params
    params.require(:trip).permit(%i[title description start_date end_date budget visibility status])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
