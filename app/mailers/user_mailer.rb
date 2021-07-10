# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "staff@trvlr.com"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to trvlr!")
  end

  def added_to_trip
    @user = params[:user]
    @invited_user = params[:invited_user]
    @trip = params[:trip]
    mail(to: @invited_user.email, subject: "#{@user.username} added you to their trip \"#{@trip.title}\"")
  end
end
