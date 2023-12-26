# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController do
  describe 'GET home' do
    it 'responds successfully with an HTTP 200 status code' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
