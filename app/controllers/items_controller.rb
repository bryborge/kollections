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
    @item = @collection.items.build
    build_properties_for_collection(@collection)
  end

  # GET /collections/:collection_id/items/:id/edit
  def edit; end

  # POST /collections/:collection_id/items
  def create
    @item = @collection.items.build(item_params)

    if @item.save
      redirect_to [@collection, @item], notice: I18n.t('notices.item_created')
    else
      flash.now[:alert] = I18n.t('alerts.item_not_created')
      render :new
    end
  end

  # PATCH/PUT /collections/:collection_id/items/:id
  def update
    if @item.update(item_params)
      redirect_to [@collection, @item], notice: I18n.t('notices.item_updated')
    else
      flash.now[:alert] = I18n.t('alerts.item_not_updated')
      render :edit
    end
  end

  # DELETE /collections/:collection_id/items/:id
  def destroy
    if @item.destroy
      redirect_to @collection, notice: I18n.t('notices.item_destroyed')
    else
      redirect_to [@collection, @item], alert: I18n.t('alerts.item_not_destroyed')
    end
  end

  private

  def set_collection
    @collection = current_user.collections.find_by(id: params[:collection_id])
    redirect_to(root_path, alert: I18n.t('alerts.collection_not_found')) unless @collection
  end

  def set_item
    @item = @collection.items.find_by(id: params[:id])
    redirect_to([@collection, @item], alert: I18n.t('alerts.item_not_found')) unless @item
  end

  def item_params
    params.require(:item).permit(:name, :description, :acquisition_date,
                                 properties_attributes: %i[id name value _destroy])
  end

  def build_properties_for_collection(collection)
    collection_type_properties = Collection::COLLECTION_PROPERTIES[collection.kind]

    return unless collection_type_properties

    collection_type_properties.each do |property_name|
      @item.properties.build(name: property_name)
    end
  end
end
