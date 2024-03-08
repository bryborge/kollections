# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs out' do
  include_context 'when user signed in'

  it 'successfully' do
    # Sign out
    click_button 'Sign Out'

    # Expect to see sign in link and not sign out link
    expect(page).to have_link('Sign In')
    expect(page).not_to have_button('Sign Out')
  end
end
