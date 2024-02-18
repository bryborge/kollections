# frozen_string_literal: true

# Items
class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_item, only: %i[show edit update destroy]

  # GET /collections/:collection_id/items/:id
  def show; end

  # GET /collections/:collection_id/items/new
  def new
    @item = Item.new
  end

  # GET /collections/:collection_id/items/:id/edit
  def edit; end

  # POST /collections/:collection_id/items
  def create
    @item = @collection.items.build(item_params)

    if @item.save
      redirect_to [@collection, @item], notice: I18n.t('notices.item_created')
    else
      render :new
    end
  end

  # PATCH/PUT /collections/:collection_id/items/:id
  def update
    if @item.update(item_params)
      redirect_to [@collection, @item], notice: I18n.t('notices.item_updated')
    else
      render :edit
    end
  end

  # DELETE /collections/:collection_id/items/:id
  def destroy
    @item.destroy
    redirect_to @collection, notice: I18n.t('notices.item_destroyed')
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :acquisition_date)
  end

  def set_collection
    @collection = current_user&.collections&.find_by(id: params[:collection_id])
  end

  def set_item
    @item = @collection.items.find(params[:id]) if @collection
  end
end
