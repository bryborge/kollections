# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collections' do
  let(:user) { create(:user) }
  let!(:collection) { create(:collection, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get collections_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      let!(:collections) { create_list(:collection, 2, user:) }

      it 'responds successfully with an HTTP 200 status code' do
        get collections_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        get collections_path
        collections.each do |collection|
          expect(response.body).to include(collection.name)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when the collection exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get collection_path(collection)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get collection_path(collection)
        expect(response.body).to include(collection.name)
      end
    end

    context 'when the collection does not exist' do
      it 'responds with a 404 not found status' do
        get collection_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #new' do
    it 'responds successfully with an HTTP 200 status code' do
      get new_collection_path
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the new collection form' do
      get new_collection_path
      expect(response.body).to include('form')
      expect(response.body).to include('name="collection[name]"')
      expect(response.body).to include('name="collection[description]"')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { collection: attributes_for(:collection) } }

      it 'creates a new collection' do
        expect do
          post collections_path, params: valid_attributes
        end.to change(Collection, :count).by(1)
      end

      it 'redirects to the collections page' do
        post collections_path, params: valid_attributes
        expect(response).to redirect_to(Collection.last)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { collection: attributes_for(:collection, name: nil) } }

      it 'does not save the new collection' do
        expect do
          post collections_path, params: invalid_attributes
        end.not_to change(Collection, :count)
      end

      it "returns a 200 status code indicating the 'new' template is re-rendered" do
        post collections_path, params: invalid_attributes
        expect(response).to have_http_status(:ok)
      end

      it 'shows validation errors' do
        post collections_path, params: invalid_attributes
        expect(response.body).to include('can&#39;t be blank')
      end
    end
  end

  describe 'GET /collections/:id/edit' do
    it 'renders the edit form' do
      get edit_collection_path(collection)
      expect(response).to be_successful
      expect(response.body).to include('Edit Collection')
    end
  end

  describe 'PATCH /collections/:id' do
    context 'with valid attributes' do
      let(:valid_attributes) { { name: 'Updated Collection Name', description: 'Updated Description' } }

      it 'updates the collection' do
        patch collection_path(collection), params: { collection: valid_attributes }
        collection.reload
        expect(collection.name).to eq(valid_attributes[:name])
        expect(collection.description).to eq(valid_attributes[:description])
      end

      it 'redirects to the collection' do
        patch collection_path(collection), params: { collection: valid_attributes }
        expect(response).to redirect_to(collection_path(collection))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { name: '', description: 'Still Updated Description' } }

      it 'does not update the collection' do
        patch collection_path(collection), params: { collection: invalid_attributes }
        original_name = collection.name
        collection.reload
        expect(collection.name).to eq(original_name)
      end

      it "re-renders the 'edit' form" do
        patch collection_path(collection), params: { collection: invalid_attributes }
        expect(response.body).to include('Edit Collection')
      end
    end
  end

  describe 'DELETE /collections/:id' do
    it 'deletes the collection' do
      expect do
        delete collection_path(collection)
      end.to change(Collection, :count).by(-1)
    end

    it 'redirects to the collections index' do
      delete collection_path(collection)
      expect(response).to redirect_to(collections_path)
      follow_redirect!
      expect(response.body).to include('Collections')
    end

    it 'sets a notice that the collection was deleted' do
      delete collection_path(collection)
      follow_redirect!
      expect(flash[:notice]).to match(I18n.t('notices.collection_destroyed'))
    end
  end
end
