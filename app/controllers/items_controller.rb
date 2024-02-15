# frozen_string_literal: true

# Items in Collections
class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_collection_item, only: %i[show]

  # GET /collections/:collections_id/items/:id
  def show
    @item = Item.find(params[:id])
  end

  private

  def set_collection
    @collection = current_user&.collections&.find(params[:collection_id])
  end

  def set_collection_item
    @item = @collection.items.find(params[:id]) if @collection
  end
end
