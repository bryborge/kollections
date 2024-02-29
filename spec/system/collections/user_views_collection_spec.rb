# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User views a collection' do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  context 'when the collection does not have any items' do
    before { visit collection_path(collection) }

    it "doesn't show any items" do
      expect(page).to have_content('No items to show.')
    end
  end

  context 'when the collection has items' do
    let!(:items) { create_list(:item, 3, collection:) }

    before { visit collection_path(collection) }

    it 'displays a table of the items' do
      expect(page).to have_css('.table.table-hover tbody tr', count: items.count)
    end
  end
end
