require 'rails_helper'

RSpec.describe 'entries/show', type: :view do
  let!(:user) { User.create!(name: 'Princess Bacon') }
  let!(:team) { Team.create!(name: 'The Mighty Morphin Stock Exchangers') }
  let!(:wallet) { Wallet.create!(owner: user) }
  let!(:bottomless_wallet) { BottomlessWallet.create!(owner: team) }
  let(:debit) { Debit.new(amount: 1.1, wallet: bottomless_wallet) }
  let(:credit) { Credit.new(amount: 1.1, wallet: wallet) }

  before(:each) do
    assign(:entry, Entry.create!(debits: [debit], credits: [credit]))
  end

  it 'renders debits' do
    render
    expect(rendered).to match('1.1 from The Mighty Morphin Stock Exchangers')
  end

  it 'renders credits' do
    render
    expect(rendered).to match('1.1 to Princess Bacon')
  end
end
