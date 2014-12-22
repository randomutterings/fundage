require 'spec_helper'

RSpec.describe OwnersController, type: :controller do
  let(:valid_attributes) { { name: 'Red Rover' } }
  let(:invalid_attributes) { { name: nil } }

  describe 'GET index' do
    it 'assigns all owners as @owners' do
      user = User.create!(name: 'Princess Bacon')
      team = Team.create!(name: 'The Mighty Morphin Stock Exchangers')
      get :index
      expect(assigns(:owners)).to match_array([user, team])
    end
  end

  describe 'GET show' do
    it 'assigns the requested owner as @owner' do
      owner = Owner.create! valid_attributes
      get :show, id: owner.to_param
      expect(assigns(:owner)).to eq(owner)
    end
  end

  describe 'GET new' do
    it 'assigns a new owner as @owner' do
      get :new
      expect(assigns(:owner)).to be_a_new(Owner)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Owner' do
        # rubocop:disable Style/Blocks
        expect {
          post :create, owner: valid_attributes
        }.to change(Owner, :count).by(1)
        # rubocop:enable Style/Blocks
      end

      it 'assigns a newly created owner as @owner' do
        post :create, owner: valid_attributes

        expect(assigns(:owner)).to be_a(Owner)
        expect(assigns(:owner)).to be_persisted
      end

      it 'redirects to the created owner' do
        post :create, owner: valid_attributes
        expect(response).to redirect_to(Owner.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved owner as @owner' do
        post :create, owner: invalid_attributes
        expect(assigns(:owner)).to be_a_new(Owner)
      end

      it "re-renders the 'new' template" do
        post :create, owner: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end
end
