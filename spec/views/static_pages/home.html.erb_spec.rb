# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'static_pages/home' do
  it 'displays the welcome message' do
    render
    expect(rendered).to match(/Welcome to Kollections/)
  end

  context 'when user is not signed in' do
    it 'displays the sign up link' do
      allow(view).to receive(:user_signed_in?).and_return(false)
      render

      expect(rendered).to match(/Sign up now/)
    end
  end

  context 'when user is signed in' do
    it 'displays the sign out link' do
      allow(view).to receive(:user_signed_in?).and_return(true)
      render

      expect(rendered).not_to have_link('Sign up now')
    end
  end
end
