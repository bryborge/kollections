# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collectible do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }
  let!(:collectible) { create(:collectible, collection:) }

  it 'requires a name' do
    no_name_collectible = described_class.new(name: nil, collection_id: collection.id)

    expect(no_name_collectible).not_to be_valid
    expect(no_name_collectible.errors[:name]).to include("can't be blank")
  end

  describe 'associations' do
    it 'belongs to a collection' do
      expect(collectible).to be_valid
      expect(collectible.collection_id).to eq(collection.id)
    end
  end
end
