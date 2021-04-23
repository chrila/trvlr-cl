class WaypointsController < ApplicationController
  before_action :set_trip
  before_action :set_waypoint, only: %i[show edit update destroy]

  def index
    @waypoints = @trip.waypoints
  end

  def new
    @waypoint = @trip.waypoints.build
  end

  def edit
  end

  def show
  end

  def create
    @waypoint = @trip.waypoints.build(waypoint_params)

    respond_to do |format|
      if @waypoint.save
        format.html { redirect_to trip_waypoints_path(@trip), notice: 'Waypoint was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @waypoint.update(waypoint_params)
        format.html { redirect_to trip_waypoints_path(@trip), notice: 'Waypoint was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @waypoint.destroy
        format.html { redirect_to trip_waypoints_path(@trip), notice: 'Waypoint was successfully deleted.' }
      else
        format.html { redirect_to trip_waypoints_path(@trip), alert: 'Waypoint could not be deleted.' }
      end
    end
  end

  private

  def waypoint_params
    params.require(:waypoint).permit(%i[name notes address country continent longitude latitude])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_waypoint
    @waypoint = @trip.waypoints.find(params[:id])
  end
end
