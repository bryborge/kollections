# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collectibles' do
  let(:user) { create(:user) }
  let!(:collection) { create(:collection, user:) }
  let!(:collectible) { create(:collectible, collection:) }

  before do
    sign_in user
  end

  describe 'GET /collections/:collections_id/collectibles/:id' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get collection_collectible_path(collection, collectible)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when the collectible exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get collection_collectible_path(collection, collectible)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get collection_collectible_path(collection, collectible)
        expect(response.body).to include(collectible.name)
      end
    end

    context 'when the collectible does not exist' do
      it 'response with a 404 not found status' do
        get collection_collectible_path(collection, id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
