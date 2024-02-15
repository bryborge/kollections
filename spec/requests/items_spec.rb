# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items' do
  let(:user) { create(:user) }
  let!(:collection) { create(:collection, user:) }
  let!(:item) { create(:item, collection:) }

  before do
    sign_in user
  end

  describe 'GET /collections/:collections_id/items/:id' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get collection_item_path(collection, item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    # context 'when user is authenticated' do

    # end
    context 'when the collectable item exists' do
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

    context 'when the collectable item does not exist' do
      it 'response with a 404 not found status' do
        get collection_item_path(collection, id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
