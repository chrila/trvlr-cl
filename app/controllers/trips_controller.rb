class TripsController < ApplicationController
  before_action :set_trip, only: %i[show edit update destroy]
  before_action :authenticate_user!, unless: @trip.visibility_public?

  def new
    @trip = Trip.new
  end

  def edit; end

  def show; end

  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
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

  def index
    @trips = Trip.of_user(current_user)
  end

  private

  def trip_params
    params.require(:trip).permit(%i[title description start_date end_date budget visibility status])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
