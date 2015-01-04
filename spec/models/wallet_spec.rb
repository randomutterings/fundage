require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it 'is valid with valid attributes' do
    subject.owner = Owner.new
    expect(subject).to be_valid
  end

  it 'is not valid without an owner' do
    subject.valid?
    expect(subject.errors[:owner]).to include("can't be blank")
  end

  describe '#balance' do
    it 'calculates correctly' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#can_fund?' do
    before(:each) do
      allow(subject).to receive(:balance).and_return(10.00)
    end

    it 'is true when enough funds are available' do
      expect(subject.can_fund?(2.00)).to be_truthy
    end

    it 'is true when exactly enough funds are available' do
      expect(subject.can_fund?(10.00)).to be_truthy
    end

    it 'is false when not enough funds are available' do
      expect(subject.can_fund?(10.01)).to be_falsey
    end

    it 'is true when no funds are required' do
      expect(subject.can_fund?(0.0)).to be_truthy
    end

    it 'is false without valid params' do
      expect(subject.can_fund?(nil)).to be_falsey
    end
  end
end
