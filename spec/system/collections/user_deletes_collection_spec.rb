# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes a collection' do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit edit_collection_path(collection)
  end

  it 'succeeds' do
    click_button 'Delete Collection'

    expect(page).to have_current_path(collections_path)
    expect(page).to have_content('Collection was successfully destroyed.')
  end
end
