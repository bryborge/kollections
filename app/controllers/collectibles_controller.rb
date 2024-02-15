# frozen_string_literal: true

# Collectibles
class CollectiblesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_collectible, only: %i[show]

  # GET /collections/:collections_id/collectibles/:id
  def show
    @collectible = Collectible.find(params[:id])
  end

  private

  def set_collection
    @collection = current_user&.collections&.find(params[:collection_id])
  end

  def set_collectible
    @collectible = @collection.collectibles.find(params[:id]) if @collection
  end
end
