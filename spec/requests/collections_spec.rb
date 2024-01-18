# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collections' do
  describe 'GET /index' do
    context 'when user is not authenticated' do
      it 'redirects to the login page' do
        get collections_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      let(:user) { create(:user) }
      let!(:collections) { create_list(:collection, 2, user:) }

      before do
        sign_in user
      end

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
end
