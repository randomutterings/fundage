require 'rails_helper'

RSpec.describe Amount, type: :model do
  context 'required fields' do
    before(:each) do
      subject.valid?
    end

    it 'is not valid without a type' do
      expect(subject.errors[:type]).to include("can't be blank")
    end

    it 'is not valid without an entry' do
      expect(subject.errors[:entry]).to include("can't be blank")
    end

    it 'is not valid without a wallet' do
      expect(subject.errors[:wallet]).to include("can't be blank")
    end

    it 'is not valid without an amount' do
      expect(subject.errors[:amount]).to include('is not a number')
    end
  end

  it 'is not valid with an amount less than 0' do
    subject.amount = -0.01
    subject.valid?
    expect(subject.errors[:amount]).to include('must be greater than 0')
  end

  it 'is not valid with an amount equal to 0' do
    subject.amount = 0
    subject.valid?
    expect(subject.errors[:amount]).to include('must be greater than 0')
  end

  it 'is valid with valid attributes' do
    wallet = Wallet.new
    allow(wallet).to receive(:balance).and_return(10.00)

    subject.type = 'Debit'
    subject.entry = Entry.new
    subject.wallet = wallet
    subject.amount = 0.1

    expect(subject).to be_valid
  end
end
