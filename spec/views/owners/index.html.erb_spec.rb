require 'rails_helper'

RSpec.describe 'owners/index', type: :view do
  let!(:user) { User.create!(name: 'Princess Bacon') }
  let!(:team) { Team.create!(name: 'The Mighty Morphin Stock Exchangers') }
  let!(:wallet) { Wallet.create!(owner: user) }
  let!(:bottomless_wallet) { BottomlessWallet.create!(owner: team) }

  before(:each) do
    assign(:klass, User)
    assign(:owners, [user, team])
  end

  it 'renders users' do
    render
    expect(rendered).to match('Princess Bacon')
  end

  it 'renders teams' do
    render
    expect(rendered).to match('The Mighty Morphin Stock Exchangers')
  end
end
