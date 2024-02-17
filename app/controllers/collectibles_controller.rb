# frozen_string_literal: true

# Collectibles
class CollectiblesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_collectible, only: %i[show]

  # GET /collections/:collection_id/collectibles/:id
  def show
    @collectible = Collectible.find(params[:id])
  end

  # GET /collections/:collection_id/collectibles/new
  def new
    @collectible = Collectible.new
  end

  # POST /collections/:collection_id/collectibles
  def create
    @collectible = @collection.collectibles.build(collectible_params)

    if @collectible.save
      redirect_to [@collection, @collectible], notice: I18n.t('notices.collectible_created')
    else
      render :new
    end
  end

  private

  def collectible_params
    params.require(:collectible).permit(:name, :description)
  end

  def set_collection
    @collection = current_user&.collections&.find_by(id: params[:collection_id])
  end

  def set_collectible
    @collectible = @collection.collectibles.find(params[:id]) if @collection
  end
end
