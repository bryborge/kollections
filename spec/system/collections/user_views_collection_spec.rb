# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User views a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }

  context "when the collection doesn't exist" do
    before { visit collection_path(id: -1) }

    it 'redirects to the collections index page and displays an error' do
      expect(page).to have_current_path(collections_path)
      expect(page).to have_content('Collection not found.')
    end
  end

  context 'when the collection exists' do
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
end
