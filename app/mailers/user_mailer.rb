class UserMailer < ApplicationMailer
  default from: 'staff@trvlr.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to trvlr!')
  end
end
