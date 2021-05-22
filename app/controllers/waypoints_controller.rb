class WaypointsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip, except: %i[search distance]
  before_action :set_waypoint, only: %i[show edit update destroy increase_sequence decrease_sequence]
  authorize_resource

  def index
    @pagy, @waypoints = pagy(@trip.waypoints.order(:sequence, :id))
  end

  def new
    @waypoint = @trip.waypoints.build

    # set default values based on previous waypoint
    last_wp = @trip.waypoints.find_by(sequence: @trip.waypoints.maximum(:sequence))
    return unless last_wp

    @waypoint.country = last_wp.country
    @waypoint.continent = last_wp.continent
    @waypoint.longitude = last_wp.longitude
    @waypoint.latitude = last_wp.latitude
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

  def decrease_sequence
    @waypoint.decrease_sequence

    respond_to do |format|
      format.html { redirect_to trip_waypoints_path(@trip) }
    end
  end

  def increase_sequence
    @waypoint.increase_sequence

    respond_to do |format|
      format.html { redirect_to trip_waypoints_path(@trip) }
    end
  end

  def search
    res = Geocoder.search(params[:keyword]).first
    hash = {}

    if res
      country = ISO3166::Country.new(res.country_code)
      hash = {
        country: country.alpha2,
        continent: country.continent,
        latitude: res.latitude,
        longitude: res.longitude
      }
    end
    render json: hash
  end

  def distance
    waypoint_from = Waypoint.find(params[:id_from])
    waypoint_to = Waypoint.find(params[:id_to])
    return unless waypoint_from && waypoint_to;

    distance = waypoint_from.distance_to(waypoint_to)
    render json: { distance: distance }
  end

  private

  def waypoint_params
    params.require(:waypoint).permit(%i[name notes address country continent longitude latitude])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_waypoint
    @waypoint = @trip.waypoints.find(params[:id] || params[:waypoint_id])
  end
end
