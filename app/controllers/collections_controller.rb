# frozen_string_literal: true

# User's collections
class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections
  end
end
