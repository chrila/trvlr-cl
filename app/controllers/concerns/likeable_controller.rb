# frozen_string_literal: true

module LikeableController
  extend ActiveSupport::Concern

  included do
    authorize_resource
  end

  def create
    @likeable.like current_user
    set_likeable
  end

  def destroy
    @likeable.dislike current_user
    set_likeable
  end
end
