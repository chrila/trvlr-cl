# frozen_string_literal: true

class HomeController < ApplicationController
  skip_authorization_check

  def index
    redirect_to activities_path if signed_in?

    @trips = Trip.visibility_public
  end
end
