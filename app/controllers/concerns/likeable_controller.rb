# frozen_string_literal: true

module LikeableController
  extend ActiveSupport::Concern

  included do
    authorize_resource
  end

  def create
    @likeable.like current_user
  end

  def destroy
    @likeable.dislike current_user
  end
end
