# frozen_string_literal: true

module LikeableController
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    authorize_resource
  end

  def create
    @likeable.like current_user
    set_likeable

    render turbo_stream: turbo_stream.replace(
      element_id("like-button", @likeable), partial: "shared/like_button",
      locals: { likeable: @likeable, user: current_user, clickable: can?(:create, Like) }
    )
  end

  def destroy
    @likeable.dislike current_user
    set_likeable

    render turbo_stream: turbo_stream.replace(
      element_id("like-button", @likeable), partial: "shared/like_button",
      locals: { likeable: @likeable, user: current_user, clickable: can?(:create, Like) }
    )
  end
end
