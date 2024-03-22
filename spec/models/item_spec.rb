# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }
  let!(:item) { create(:item, collection:) }

  it 'requires a collection' do
    item_no_collection = described_class.new

    expect(item_no_collection).not_to be_valid
    expect(item_no_collection.errors[:collection]).to include('must exist')
  end

  it 'requires a name' do
    no_name_item = described_class.new(name: nil, collection_id: collection.id)

    expect(no_name_item).not_to be_valid
    expect(no_name_item.errors[:name]).to include("can't be blank")
  end

  # it 'requires an acquisition date' do
  #   no_aq_date_item = described_class.new(name: 'My Item', collection_id: collection.id, acquisition_date: '')

  #   expect(no_aq_date_item).not_to be_valid
  #   expect(no_aq_date_item.errors[:acquisition_date]).to include("can't be blank")
  # end

  describe 'associations' do
    it 'belongs to a collection' do
      expect(item).to be_valid
      expect(item.collection_id).to eq(collection.id)
    end
  end
end
