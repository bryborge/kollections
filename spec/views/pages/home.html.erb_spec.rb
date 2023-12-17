# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pages/home' do
  it 'displays the welcome message' do
    render
    expect(rendered).to match(/Welcome to Kollections/)
  end
end
