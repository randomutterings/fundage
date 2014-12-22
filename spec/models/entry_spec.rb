require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:wallet) { Wallet.new }
  let(:debit) { Debit.new(amount: 1.1, wallet: wallet) }
  let(:credit) { Credit.new(amount: 1.1, wallet: wallet) }

  before(:each) do
    allow(wallet).to receive(:balance).and_return(10.00)
  end

  it 'is not valid without a credit' do
    subject.valid?
    expect(subject.errors[:credits]).to include("can't be blank")
  end

  it 'is not valid without a debit' do
    subject.valid?
    expect(subject.errors[:debits]).to include("can't be blank")
  end

  it 'is not valid with an invalid debit' do
    allow(debit).to receive(:valid?).and_return(false)

    subject.debits << debit
    subject.valid?
    expect(subject.errors[:debits]).to include('is invalid')
  end

  it 'is not valid with an invalid credit' do
    allow(credit).to receive(:valid?).and_return(false)

    subject.credits << credit
    subject.valid?
    expect(subject.errors[:credits]).to include('is invalid')
  end

  it 'is not valid when debits and credits are not equal' do
    subject.debits << debit
    subject.credits << Credit.new(amount: 100.1, wallet: wallet)
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.debits << debit
    subject.credits << credit
    expect(subject).to be_valid
  end
end
