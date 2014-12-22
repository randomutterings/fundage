require 'rails_helper'

RSpec.describe Debit, type: :model do
  let(:wallet) { Wallet.new }
  let(:entry) { Entry.new }

  subject { Debit.new(wallet: wallet, entry: entry, amount: 0.1) }

  before(:each) do
    allow(wallet).to receive(:balance).and_return(10.00)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context '#funded?' do
    it 'is false without enough funds' do
      subject.amount = 10.01
      expect(subject.funded?).to be_falsey
    end
  end
end
