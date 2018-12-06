class SuspectsController < ApplicationController
  before_action :check_login
  authorize_resource

  def new
    @suspect = Suspect.new
    unless params[:investigation_id].nil?
      @investigation    = Investigation.find(params[:investigation_id])
      @investigation_criminals = @investigation.suspects.current.map{|c| c.criminal }
    end
  end
  
  def create
    @suspect = Suspect.new(suspect_params)
    @suspect.added_on = Date.current
    if @suspect.save
      flash[:notice] = "Successfully added suspect."
      redirect_to investigation_path(@suspect.investigation)
    else
      unless params[:suspect][:investigation_id] == ""
        @investigation     = Investigation.find(params[:suspect][:investigation_id])
        @investigation_criminals = @investigation.suspects.current.map{|c| c.criminal }
        render action: 'new', locals: { investigation: @investigation, investigation_criminals: @investigation_criminals }
      end
    end
  end

  def remove
    @suspect = Suspect.find(params[:id])
    @suspect.dropped_on = Date.current
    @suspect.save
    flash[:notice] = "Suspect has been dropped"
    redirect_to investigation_path(@suspect.investigation)
  end
  
  private
  def suspect_params
    params.require(:suspect).permit(:investigation_id, :criminal_id, :added_on, :dropped_on)
  end
end
