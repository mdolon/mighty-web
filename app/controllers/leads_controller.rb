class LeadsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  def index
    @leads = Lead.all
    respond_with(@leads)
  end

  def show
    respond_with(@lead)
  end

  def new
    @lead = Lead.new
    respond_with(@lead)
  end

  def edit
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      begin
        LeadNotifier.lead_email(@lead).deliver
      rescue
      end
    else
      render :action => 'new'
    end
    respond_with(@lead)
  end

  def update
    @lead.update(lead_params)
    respond_with(@lead)
  end

  def destroy
    @lead.destroy
    respond_with(@lead)
  end

  private
    def set_lead
      @lead = Lead.find(params[:id])
    end

    def lead_params
      params.require(:lead).permit(:name, :objective, :activities, :pricepoint, :email, :startdate, :location)
    end
end
