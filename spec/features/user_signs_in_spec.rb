# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs in' do
  it 'with valid credentials' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  it 'with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid'
    fill_in 'Password', with: 'invalidpass'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
