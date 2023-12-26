# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs up' do
  it 'with valid credentials' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'with invalid email' do
    visit new_user_registration_path

    fill_in 'Email', with: 'invalid'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Email is invalid')
  end
end
