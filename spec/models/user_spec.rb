# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:valid_user) { create(:user) }
  let(:invalid_email_user) { build(:user, email: 'invalid_email') }
  let(:invalid_password_user) { build(:user, password: 'short') }
  let(:confirmation_mismatch_user) { build(:user, password_confirmation: 'different') }

  let!(:stamp_collection) { create(:collection, user: valid_user) }
  let!(:spoon_collection) { create(:collection, user: valid_user) }

  it 'has email and password fields' do
    expect(valid_user).to be_valid
  end

  it 'is not valid without a valid email' do
    expect(invalid_email_user).not_to be_valid
  end

  it 'is not valid without a valid password' do
    expect(invalid_password_user).not_to be_valid
  end

  it 'is not valid if password and confirmation do not match' do
    expect(confirmation_mismatch_user).not_to be_valid
  end

  describe 'associations' do
    it 'has many collections' do
      expect(valid_user.collections.length).to eq 2
      expect(valid_user.collections).to include(stamp_collection, spoon_collection)
    end

    it 'destroys collections when user is deleted' do
      expect { valid_user.destroy }.to change(Collection, :count).by(-2)
    end
  end
end
