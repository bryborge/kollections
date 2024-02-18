# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs out' do
  it 'successfully' do
    user = create(:user)

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    # Sign out
    click_button 'Sign Out'

    # Expect to see sign in link and not sign out link
    expect(page).to have_link('Sign In')
    expect(page).not_to have_button('Sign Out')
  end
end
