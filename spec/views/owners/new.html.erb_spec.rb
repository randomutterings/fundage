require 'rails_helper'

RSpec.describe 'owners/new', type: :view do
  before(:each) do
    assign(:owner, Owner.new)
  end

  it 'renders new owner form' do
    render
    expect(rendered).to match('<form class="simple_form new_owner" id="new_owner" action="/owners" accept-charset="UTF-8" method="post">')
  end
end
