require 'rails_helper'

RSpec.describe 'owners/show', type: :view do
  let!(:user) { User.create!(name: 'Princess Bacon') }
  let!(:team) { Team.create!(name: 'The Mighty Morphin Stock Exchangers') }
  let!(:wallet) { Wallet.create!(owner: user) }
  let!(:bottomless_wallet) { BottomlessWallet.create!(owner: team) }
  let(:debit) { Debit.new(amount: 1.1, wallet: bottomless_wallet) }
  let(:credit) { Credit.new(amount: 1.1, wallet: wallet) }

  context 'when owner is a user' do
    before(:each) do
      Entry.create!(debits: [debit], credits: [credit])
      assign(:klass, User)
      assign(:owner, user)
    end

    it 'renders debits' do
      render
      expect(rendered).to match('1.1 from The Mighty Morphin Stock Exchangers')
    end
  end

  context 'when owner is a team' do
    before(:each) do
      Entry.create!(debits: [debit], credits: [credit])
      assign(:klass, Team)
      assign(:owner, team)
    end

    it 'renders credits' do
      render
      expect(rendered).to match('1.1 to Princess Bacon')
    end
  end
end
