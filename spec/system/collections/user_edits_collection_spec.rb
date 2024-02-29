# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User edits a collection' do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit edit_collection_path(collection)
  end

  it 'with valid attributes' do
    fill_in 'Name', with: 'Comic Books'
    fill_in 'Description', with: 'This is my entire comic book collection.'
    fill_in 'Kind', with: 'comics'
    click_button 'Update'

    expect(page).to have_current_path(collection_path(collection))
    expect(page).to have_content('Collection was successfully updated.')
  end

  it 'with invalid attributes' do
    fill_in 'Name', with: ''
    fill_in 'Description', with: 'This is my entire comic book collection.'
    fill_in 'Kind', with: ''
    click_button 'Update'

    expect(page).to have_current_path(collection_path(collection))
    expect(page).to have_content('Collection was not updated.')
  end
end
