# frozen_string_literal: true

# User's collections
class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: %i[show edit update destroy]

  # GET /collections
  def index
    @collections = current_user.collections
  end

  # GET /collection/:id
  def show; end

  # GET /collections/new
  def new
    @collection = current_user.collections.build
  end

  # GET /collections/:id/edit
  def edit; end

  # POST /collections
  def create
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to @collection, notice: I18n.t('notices.collection_created')
    else
      flash.now[:alert] = I18n.t('alerts.collection_not_created')
      render :new
    end
  end

  # PATCH/PUT /collections/:id
  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: I18n.t('notices.collection_updated')
    else
      flash.now[:alert] = I18n.t('alerts.collection_not_updated')
      render :edit
    end
  end

  # DELETE /collections/:id
  def destroy
    @collection.destroy
    redirect_to collections_url, notice: I18n.t('notices.collection_destroyed')
  end

  private

  def set_collection
    @collection = current_user.collections.find_by(id: params[:id])

    return if @collection

    redirect_to collections_url, alert: I18n.t('alerts.collection_not_found')
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :kind)
  end
end
