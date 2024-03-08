# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs in' do
  let(:user) { create(:user) }

  it 'with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid'
    fill_in 'Password', with: 'invalidpass'
    click_button 'Sign in'

    expect(page).to have_content('Invalid Email or password.')
  end

  describe 'with valid credentials' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    it 'succeeds' do
      expect(page).to have_content('Signed in successfully.')
    end

    describe 'and is redirected' do
      it 'to the collections page' do
        expect(page).to have_current_path(collections_path, ignore_query: true)
      end
    end
  end
end
