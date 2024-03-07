# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes an item within a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }
  let(:item) { create(:item, collection:) }

  before { visit edit_collection_item_path(collection, item) }

  it 'succeeds' do
    click_button 'Delete Item'

    expect(page).to have_current_path(collection_path(collection))
    expect(page).to have_content('Item was successfully destroyed.')
  end
end
