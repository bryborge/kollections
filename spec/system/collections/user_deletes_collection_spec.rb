# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }

  before { visit edit_collection_path(collection) }

  it 'succeeds' do
    click_button 'Delete Collection'

    expect(page).to have_current_path(collections_path)
    expect(page).to have_content('Collection was successfully destroyed.')
  end
end
