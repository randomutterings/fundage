# Endpoints to list, display, and create entries
class EntriesController < ApplicationController
  respond_to :html, :json

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @entry.credits << Credit.new
    @entry.debits << Debit.new
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    flash[:notice] = 'Entry was successfully created.' if @entry.save
    respond_with(@entry)
  end

  private

  def entry_params
    params.require(:entry).permit(credits_attributes: [:wallet_id, :amount],
                                  debits_attributes: [:wallet_id, :amount])
  end
end
