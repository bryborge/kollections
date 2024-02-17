# frozen_string_literal: true

# Items
class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_item, only: %i[show]

  # GET /collections/:collection_id/items/:id
  def show
    @item = Item.find(params[:id])
  end

  # GET /collections/:collection_id/Ims/new
  def new
    @item = Item.new
  end

  # POST /collections/:collection_id/items
  def create
    @item = @collection.items.build(item_params)

    if @item.save
      redirect_to [@collection, @item], notice: I18n.t('notices.item_created')
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end

  def set_collection
    @collection = current_user&.collections&.find_by(id: params[:collection_id])
  end

  def set_item
    @item = @collection.items.find(params[:id]) if @collection
  end
end
