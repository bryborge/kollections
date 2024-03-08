# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController do
  describe 'GET home' do
    it 'responds successfully with an HTTP 200 status code' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET help' do
    it 'responds successfully with an HTTP 200 status code' do
      get help_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET about' do
    it 'responds successfully with an HTTP 200 status code' do
      get about_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET contact' do
    it 'responds successfully with an HTTP 200 status code' do
      get contact_path
      expect(response).to have_http_status(:ok)
    end
  end
end
