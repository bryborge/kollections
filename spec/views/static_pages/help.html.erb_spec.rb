# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'static_pages/help' do
  it 'displays the page title' do
    render
    expect(rendered).to match(/Help/)
  end
end
