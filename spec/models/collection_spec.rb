# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user:) }

  it 'requires a user' do
    collection_no_user = described_class.new

    expect(collection_no_user).not_to be_valid
    expect(collection_no_user.errors[:user]).to include('must exist')
  end

  it 'requires a name' do
    no_name_collection = described_class.new(name: nil, user_id: user.id)

    expect(no_name_collection).not_to be_valid
    expect(no_name_collection.errors[:name]).to include("can't be blank")
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(collection).to be_valid
      expect(collection.user_id).to eq(user.id)
    end

    it 'has many items' do
      create_list(:item, 3, collection:)
      expect(collection&.items&.length).to eq 3
    end

    it 'destroys the associated items when collection is deleted' do
      create_list(:item, 3, collection:)
      expect { collection.destroy }.to change(Item, :count).by(-3)
    end
  end
end
