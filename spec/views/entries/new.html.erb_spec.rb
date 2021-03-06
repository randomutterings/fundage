require 'rails_helper'

RSpec.describe 'entries/new', type: :view do
  before(:each) do
    assign(:wallets, Wallet.all)
    assign(:entry, Entry.new(debits: [Debit.new], credits: [Credit.new]))
  end

  it 'renders new entry form' do
    render
    expect(rendered).to match('<form accept-charset="UTF-8" action="/entries" class="simple_form new_entry" id="new_entry" method="post">')
  end

  it 'renders fields for debits' do
    render
    expect(rendered).to match(I18n.t('simple_form.labels.debits.amount'))
  end

  it 'renders fields for credits' do
    render
    expect(rendered).to match(I18n.t('simple_form.labels.credits.amount'))
  end
end
