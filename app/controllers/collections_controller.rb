# frozen_string_literal: true

# User's collections
class CollectionsController < ApplicationController
  before_action :authenticate_user!

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

  # POST /collections
  def create
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to @collection, notice: I18n.t('notices.collection_created')
    else
      render :new
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
