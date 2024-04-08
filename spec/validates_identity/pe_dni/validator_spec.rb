# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::PeDni::Validator do
  it 'rejects 1.123.123' do
    expect(described_class.new('1.123.123')).not_to be_valid
  end

  it 'rejects 12.12.123' do
    expect(described_class.new('12.12.123')).not_to be_valid
  end

  it 'rejects 12.123.12' do
    expect(described_class.new('12.123.12')).not_to be_valid
  end

  it 'rejects 12345' do
    expect(described_class.new('12345')).not_to be_valid
  end

  it 'accepts blank string' do
    expect(described_class.new('')).to be_valid
  end

  it 'accepts nil' do
    expect(described_class.new(nil)).to be_valid
  end

  it 'accepts 178011460' do
    expect(described_class.new('178011460')).to be_valid
  end

  it 'accepts 17801146-0' do
    expect(described_class.new('17801146-0')).to be_valid
  end
end
