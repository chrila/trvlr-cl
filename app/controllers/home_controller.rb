class HomeController < ApplicationController
  def index
    redirect_to activities_path if signed_in?

    @trips = Trip.visibility_public
  end
end
