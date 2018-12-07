class CrimeInvestigationsController < ApplicationController
  before_action :check_login
  authorize_resource
  
  def new
    @crime_investigation = CrimeInvestigation.new
    @investigation    = Investigation.find(params[:investigation_id])
  end

  def create
    @crime_investigation = CrimeInvestigation.new(crime_investigation_params)
    if @crime_investigation.save
      redirect_to investigation_path(@crime_investigation.investigation)
    else
      @investigation = Investigation.find(params[:crime_investigation][:investigation_id])
      render action: 'new', locals: { investigation: @investigation }
    end 
  end
  
  def destroy
    @crime_investigation = CrimeInvestigation.find(params[:id])
    @investigation = @crime_investigation.investigation
    if @crime_investigation.destroy
      redirect_to investigation_path(@investigation)
    end
  end

  private
  def crime_investigation_params
    params.require(:crime_investigation).permit(:investigation_id, :crime_id)
  end
end
