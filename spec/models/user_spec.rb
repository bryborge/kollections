# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it 'has email and password fields' do
    user = described_class.new(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user).to be_valid
  end

  it 'is not valid without a valid email' do
    user = described_class.new(email: 'invalid_email', password: 'password123', password_confirmation: 'password123')
    expect(user).not_to be_valid
  end

  it 'is not valid without a valid password' do
    user = described_class.new(email: 'test@example.com', password: 'short', password_confirmation: 'short')
    expect(user).not_to be_valid
  end

  it 'is not valid if password and confirmation do not match' do
    user = described_class.new(email: 'test@example.com', password: 'password123', password_confirmation: 'different')
    expect(user).not_to be_valid
  end
end
