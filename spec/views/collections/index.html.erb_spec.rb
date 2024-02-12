# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'collections/index' do
  let!(:collection_one) { create(:collection, name: 'Collection One') }
  let!(:collection_two) { create(:collection, name: 'Collection Two') }

  before do
    assign(:collections, [
             collection_one,
             collection_two
           ])
  end

  it 'displays the page header' do
    render
    expect(rendered).to match(/Your Collections/)
  end

  it 'displays all collections with links' do
    render

    collections = [collection_one, collection_two]

    # Check for each collection link
    expect(rendered).to have_link('Collection One', href: collection_path(collections.first))
    expect(rendered).to have_link('Collection Two', href: collection_path(collections.second))
  end

  it "displays the 'New Collection' button" do
    render
    expect(rendered).to have_link('New Collection', href: new_collection_path)
  end
end
