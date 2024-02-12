# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user_id: user.id) }

  it 'belongs to a user' do
    expect(collection).to be_valid
    expect(collection.user_id).to eq(user.id)
  end

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
end
