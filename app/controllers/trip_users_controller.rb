# frozen_string_literal: true

class TripUsersController < ApplicationController
  before_action :set_trip
  before_action :set_trip_user, only: %i[show edit update destroy]
  authorize_resource

  def index
    @trip_users = @trip.trip_users.order(:id)
  end

  def new
    @trip_user = @trip.trip_users.build
  end

  def edit
  end

  def show
  end

  def create
    @trip_user = @trip.trip_users.build(trip_user_params)

    respond_to do |format|
      if @trip_user.save
        format.html { redirect_to trip_trip_users_path(@trip), notice: 'Participant was successfully added to the trip.' }
        UserMailer.with(user: current_user, invited_user: @trip_user.user, trip: @trip).added_to_trip.deliver_later
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip_user.update(trip_user_params)
        format.html { redirect_to trip_trip_users_path(@trip), notice: 'Participant was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @trip_user.destroy
        format.html { redirect_to trip_trip_users_path(@trip), notice: 'Participant was successfully removed from the trip.' }
      else
        format.html { redirect_to trip_trip_users_path(@trip), alert: 'Participant could not be removed from the trip.' }
      end
    end
  end

  private

  def trip_user_params
    params.require(:trip_user).permit(%i[user_id trip_id role])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_trip_user
    @trip_user = @trip.trip_users.find(params[:id])
  end
end
