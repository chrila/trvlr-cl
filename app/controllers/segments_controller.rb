# frozen_string_literal: true

class SegmentsController < ApplicationController
  include Pagy::Backend

  before_action :set_trip
  before_action :set_segment, only: %i[show edit update destroy increase_sequence decrease_sequence]
  authorize_resource

  def index
    @pagy, @segments = pagy(@trip.segments.order(:sequence, :id))
  end

  def new
    @segment = @trip.segments.build

    # set default values based on previous segment
    last_sg = @trip.segments.find_by(sequence: @trip.segments.maximum(:sequence))
    return unless last_sg

    @segment.waypoint_from = last_sg.waypoint_to
    @segment.waypoint_to = last_sg.waypoint_to
    @segment.time_from = last_sg.time_to
    @segment.time_to = last_sg.time_to
    @segment.means_of_travel = last_sg.means_of_travel
  end

  def edit
  end

  def show
  end

  def create
    @segment = @trip.segments.build(segment_params)

    respond_to do |format|
      if @segment.save
        format.html { redirect_to trip_segments_path(@trip), notice: "Segment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @segment.update(segment_params)
        format.html { redirect_to trip_segments_path(@trip), notice: "Segment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @segment.destroy
        format.html { redirect_to trip_segments_path(@trip), notice: "Segment was successfully deleted." }
      else
        format.html { redirect_to trip_segments_path(@trip), alert: "Segment could not be deleted." }
      end
    end
  end

  def decrease_sequence
    @segment.decrease_sequence

    respond_to do |format|
      format.html { redirect_to trip_segments_path(@trip) }
    end
  end

  def increase_sequence
    @segment.increase_sequence

    respond_to do |format|
      format.html { redirect_to trip_segments_path(@trip) }
    end
  end

  private
    def segment_params
      params.require(:segment).permit(%i[waypoint_from_id waypoint_to_id time_from time_to distance status means_of_travel_id])
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_segment
      @segment = @trip.segments.find(params[:id] || params[:segment_id])
    end
end
