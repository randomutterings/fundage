# Parent class for owner CRUD endpoints
# This class isn't used directly, rather
# it contains common code for child controllers
class OwnersController < ApplicationController
  respond_to :html, :json

  before_action :klass
  before_action :owner, only: [:show, :edit, :update, :destroy]

  # GET /owners
  # GET /owners.json
  def index
    @owners = @klass.all
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
  end

  # GET /owners/new
  def new
    @owner = @klass.new
  end

  # GET /owners/1/edit
  # GET /owners/1/edit.json
  def edit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = @klass.new(permitted_params)

    flash[:success] = 'Owner was successfully created.' if @owner.save && Wallet.create(owner: @owner)
    respond_with(@owner)
  end

  # PUT /owners/1/edit
  # PUT /owners/1/edit.json
  def update
    flash[:success] = 'Owner was successfully updated.' if @owner.update(permitted_params)
    respond_with(@owner)
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    if @owner.destroy
      flash[:success] = 'Owner was successfully destroyed.'
    else
      flash[:alert] = @owner.wallet.errors.full_messages.to_sentence
    end
    respond_with(@owner)
  end

  private

  def owner
    @owner ||= @klass.find(params[:id])
  end

  def klass
    @klass ||= controller_name.singularize.capitalize.constantize
  end

  def permitted_params
    params.require(@klass.to_s.downcase.to_sym).permit(:name)
  end
end
