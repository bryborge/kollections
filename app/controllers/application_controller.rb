# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    collections_path
  end
end
