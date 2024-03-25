# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User views an item within a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }

  context "when the item doesn't exist" do
    before { visit collection_item_path(collection, id: -1) }

    it 'redirects to the collection view page and displays an error' do
      expect(page).to have_current_path(collection_path(collection.id))
      expect(page).to have_content('Item not found.')
    end
  end

  context 'when the item exists' do
    let!(:item) { create(:item, collection:) }

    before { visit collection_item_path(collection, id: item.id) }

    it 'displays the item details' do
      expect(page).to have_content('Description')
    end
  end
end
