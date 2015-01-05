require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:user) { User.create!(name: 'Princess Bacon') }
  let(:team) { Team.create!(name: 'The Mighty Morphin Stock Exchangers') }
  let(:wallet) { Wallet.create!(owner: user) }
  let(:bottomless_wallet) { BottomlessWallet.create!(owner: team) }

  let!(:existing_entry) do
    Entry.create!(credits_attributes: [amount: 1.1, wallet_id: wallet.to_param],
                  debits_attributes: [amount: 1.1, wallet_id: bottomless_wallet.to_param])
  end

  describe 'GET index' do
    it 'assigns all entries as @entries' do
      get :index
      expect(assigns(:entries)).to eq([existing_entry])
    end
  end

  describe 'GET show' do
    it 'assigns the requested entry as @entry' do
      get :show, id: existing_entry.to_param
      expect(assigns(:entry)).to eq(existing_entry)
    end
  end

  describe 'GET new' do
    it 'assigns a new entry as @entry' do
      get :new
      expect(assigns(:entry)).to be_a_new(Entry)
    end
  end

  describe 'POST create' do
    let(:valid_attributes) do
      {
        'debits_attributes' => {
          '0' => { 'amount' => '1.1', 'wallet_id' => wallet.to_param }
        },
        'credits_attributes' => {
          '0' => { 'amount' => '1.1', 'wallet_id' => bottomless_wallet.to_param }
        }
      }
    end

    describe 'with valid params' do
      it 'creates a new Entry' do
        # rubocop:disable Style/Blocks
        expect {
          post :create, entry: valid_attributes
        }.to change(Entry, :count).by(1)
        # rubocop:enable Style/Blocks
      end

      it 'assigns a newly created entry as @entry' do
        post :create, entry: valid_attributes

        expect(assigns(:entry)).to be_a(Entry)
        expect(assigns(:entry)).to be_persisted
      end

      it 'redirects to the created entry' do
        post :create, entry: valid_attributes
        expect(response).to redirect_to(Entry.last)
      end
    end

    describe 'with invalid params' do
      let(:invalid_attributes) do
        {
          'credits_attributes' => {
            '0' => { 'amount' => '1.1', 'wallet_id' => bottomless_wallet.to_param }
          }
        }
      end

      it 'assigns a newly created but unsaved entry as @entry' do
        post :create, entry: invalid_attributes
        expect(assigns(:entry)).to be_a_new(Entry)
      end

      it 're-renders the "new" template' do
        post :create, entry: invalid_attributes
        expect(response).to render_template('new')
      end
    end

    describe 'with invalid nested params' do
      let(:invalid_nested_attributes) do
        {
          'debits_attributes' => {
            '0' => { 'amount' => '', 'wallet_id' => wallet.to_param }
          },
          'credits_attributes' => {
            '0' => { 'amount' => '1.1', 'wallet_id' => bottomless_wallet.to_param }
          }
        }
      end

      it 'assigns a newly created but unsaved entry as @entry' do
        post :create, entry: invalid_nested_attributes
        expect(assigns(:entry)).to be_a_new(Entry)
      end

      it 're-renders the "new" template' do
        post :create, entry: invalid_nested_attributes
        expect(response).to render_template('new')
      end
    end

    describe 'with unbalanced nested params' do
      let(:unbalanced_nested_attributes) do
        {
          'debits_attributes' => {
            '0' => { 'amount' => '', 'wallet_id' => wallet.to_param }
          },
          'credits_attributes' => {
            '0' => { 'amount' => '1.1', 'wallet_id' => bottomless_wallet.to_param }
          }
        }
      end

      it 'assigns a newly created but unsaved entry as @entry' do
        post :create, entry: unbalanced_nested_attributes
        expect(assigns(:entry)).to be_a_new(Entry)
      end

      it 're-renders the "new" template' do
        post :create, entry: unbalanced_nested_attributes
        expect(response).to render_template('new')
      end
    end
  end
end
