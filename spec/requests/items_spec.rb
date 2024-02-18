# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items' do
  let(:user) { create(:user) }
  let!(:collection) { create(:collection, user:) }
  let!(:item) { create(:item, collection:) }

  before do
    sign_in user
  end

  describe 'GET /collections/:collection_id/items/:id' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get collection_item_path(collection, item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when the item exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get collection_item_path(collection, item)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get collection_item_path(collection, item)
        expect(response.body).to include(item.name)
      end
    end

    context 'when the item does not exist' do
      it 'responds with a 302 redirect status' do
        get collection_item_path(collection, id: -1)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'GET /collections/:collection_id/items/new' do
    it 'responds successfully with an HTTP 200 status code' do
      get new_collection_item_path(collection)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the new item form' do
      get new_collection_item_path(collection)
      expect(response.body).to include('form')
      expect(response.body).to include('name="item[name]"')
      expect(response.body).to include('name="item[description]"')
      expect(response.body).to include('name="item[acquisition_date]"')
    end
  end

  describe 'POST /collections/:collection_id/items/create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { item: attributes_for(:item) } }

      it 'creats a new item' do
        expect do
          post collection_items_path(collection), params: valid_attributes
        end.to change(Item, :count).by(1)
      end

      it 'redirects to the new item page' do
        post collection_items_path(collection), params: valid_attributes
        expect(response).to redirect_to([collection, Item.last])
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { item: attributes_for(:item, name: nil) } }

      it 'does not save the new item' do
        expect do
          post collection_items_path(collection), params: invalid_attributes
        end.not_to change(Item, :count)
      end

      it "returns a 200 status code indicating the 'new' template is re-rendered" do
        post collection_items_path(collection), params: invalid_attributes
        expect(response).to have_http_status(:ok)
      end

      it 'shows validation errors' do
        post collection_items_path(collection), params: invalid_attributes
        expect(response.body).to include('can&#39;t be blank')
      end
    end
  end

  describe 'GET /collections/:collection_id/items/:id/edit' do
    it 'renders the edit form' do
      get edit_collection_item_path(collection, item)
      expect(response).to be_successful
      expect(response.body).to include('General')
    end
  end

  describe 'PATCH /collections/:collection_id/items/:id' do
    context 'with valid attributes' do
      let(:valid_attributes) { { name: 'Updated Item Name', description: 'Updated Description' } }

      it 'updates the item' do
        patch collection_item_path(collection, item), params: { item: valid_attributes }
        item.reload
        expect(item.name).to eq(valid_attributes[:name])
        expect(item.description).to eq(valid_attributes[:description])
      end

      it 'redirects to the collection' do
        patch collection_item_path(collection, item), params: { item: valid_attributes }
        expect(response).to redirect_to(collection_item_path(collection, item))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { name: '', description: 'Still Updated Description' } }

      it 'does not update the collection' do
        patch collection_item_path(collection, item), params: { item: invalid_attributes }
        original_name = item.name
        item.reload
        expect(item.name).to eq(original_name)
      end

      it "re-renders the 'edit' form" do
        patch collection_item_path(collection, item), params: { item: invalid_attributes }
        expect(response.body).to include('General')
      end
    end
  end

  describe 'DELETE /collections/:collection_id/item/:id' do
    it 'deletes the item' do
      expect do
        delete collection_item_path(collection, item)
      end.to change(Item, :count).by(-1)
    end

    it 'redirects to the collection show page' do
      delete collection_item_path(collection, item)
      expect(response).to redirect_to(collection_path(collection))
      follow_redirect!
      expect(response.body).to include(collection.name)
    end

    it 'sets a notice that the item was deleted' do
      delete collection_item_path(collection, item)
      follow_redirect!
      expect(flash[:notice]).to match(I18n.t('notices.item_destroyed'))
    end
  end
end
