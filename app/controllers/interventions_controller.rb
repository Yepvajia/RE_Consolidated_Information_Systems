require 'rest-client'
require "json"
class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  # GET /interventions or /interventions.json
  def index
    if current_user
      if current_user.admin != 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    @interventions = Intervention.all
  end

  # GET /interventions/1 or /interventions/1.json
  def show
    if current_user
      if current_user.admin != 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # GET /interventions/new
  def new
    if current_user
      if current_user.admin != 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    @intervention = Intervention.new
  end

  # GET /interventions/1/edit
  def edit
    if current_user
      if current_user.admin != 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)
    @intervention.author_id = current_user.id
    @intervention.customer_id = @intervention.customer_id.to_i
    @intervention.building_id = @intervention.building_id.to_i
    @intervention.battery_id = @intervention.battery_id.to_i
    @intervention.column_id = @intervention.column_id.to_i
    @intervention.elevator_id = @intervention.elevator_id.to_i
    @intervention.employee_id = @intervention.employee_id.to_i


    respond_to do |format|
      if @intervention.save
        data = {
          email: @intervention.author.email, 
          priority: 4, 
          status: 3,
          type: "Question",
          subject: "Ticket From #{@intervention.author.first_name}",
          description: "<h2>Here is all the info from the ticket:</h2><br>
          <b>Requester:</b> #{@intervention.author.first_name} #{@intervention.author.last_name}<br>
          <b>Customer:</b> #{@intervention.customer.company_name}<br>
          <b>Building ID:</b> #{@intervention.building_id}<br>
          <b>Battery ID:</b> #{@intervention.battery_id}<br>
          <b>Column ID:</b> #{@intervention.column_id}<br>
          <b>Elevator ID:</b> #{@intervention.elevator_id}<br>
          <b>Employee ID:</b> #{@intervention.employee_id}<br>
          <b>Description:</b> #{@intervention.report}"
        }.to_json
        request  = RestClient::Request.execute(
          method: :post, 
          url: 'https://rocketelevator-support.freshdesk.com/api/v2/tickets',
          user: ENV['FRESHDESK_KEY'],
          password: "x",
          headers: {
            content_type: "application/json"
          },
          payload: data
        )
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully created." }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:author_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :start_date, :end_date, :result, :report, :status)
    end
end
