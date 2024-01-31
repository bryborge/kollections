# frozen_string_literal: true

# User's collections
class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: %i[show edit update]

  # GET /collections
  def index
    @collections = current_user.collections
  end

  # GET /collection/{id}
  def show
    @collection = Collection.find(params[:id])
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/{id}/edit
  def edit
    @collection = Collection.find(params[:id])
  end

  # POST /collections
  def create
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to @collection, notice: I18n.t('notices.collection_created')
    else
      render :new
    end
  end

  # PATCH/PUT /collections/{id}
  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: I18n.t('notices.collection_updated')
    else
      render :edit
    end
  end

  private

  def set_collection
    @collection = current_user.collections.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
