require 'rails_helper'

RSpec.describe Owner, type: :model do
  it 'is valid with valid attributes' do
    subject.name = 'Bob'
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end
end
