require 'rest-client'
require "json"

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    respond_to do |format|
      if @quote.save
        quote_form = {
          email: "rocket_elevator_client@test.com", 
          priority: 1, 
          status: 2,
          type: "Feature Request",
          subject: "From #{@quote.price}",
          description: "building type: #{@quote.building_type}, " + " number of appartment: #{@quote.number_of_apartments}, " + " number of floor: #{@quote.number_of_floors}, " + " number of elevator: #{@quote.number_of_elevators}, " + " message: #{@quote.business_hours}",
        }.to_json
        puts quote_form
        quote_ticket = RestClient::Request.execute(
          method: :post, 
          url: "https://rocketelevator-support.freshdesk.com/api/v2/tickets",
          user: ENV['FRESHDESK_KEY'],
          password: "x",
          headers: {
            content_type: "application/json"
          },
          payload: quote_form
        )
        puts quote_ticket

      # if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      # end
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:building_type, :price, :number_of_apartments, :number_of_companies, :number_of_corporations, :number_of_floors, :number_of_basements, :number_of_parking_spots, :number_of_elevators, :maximum_occupancy, :business_hours)
    end
end
