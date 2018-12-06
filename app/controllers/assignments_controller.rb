class AssignmentsController < ApplicationController
  before_action :check_login
  authorize_resource


  def new
    @assignment = Assignment.new
    session[:back] = request.referrer
    unless params[:officer_id].nil?
      @officer    = Officer.find(params[:officer_id])
      @officer_investigations = @officer.assignments.current.map{|a| a.investigation }
    end
    unless params[:investigation_id].nil?
      @investigation    = Investigation.find(params[:investigation_id])
      @investigation_officers = @investigation.assignments.current.map{|a| a.officer }
    end
  end
  
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.start_date = Date.current
    if @assignment.save
      flash[:notice] = "Successfully added assignment."
      redirect_to session[:back]
    else
      unless params[:assignment][:officer_id] == ""
        @officer     = Officer.find(params[:assignment][:officer_id])
        @officer_investigations = @officer.assignments.current.map{|a| a.investigation }
        render action: 'new', locals: { officer: @officer, officer_investigations: @officer_investigations }
      end
      unless params[:assignment][:investigation_id] == ""
        @investigation     = Investigation.find(params[:assignment][:investigation_id])
        @investigation_officers = @investigation.assignments.current.map{|a| a.officer }
        render action: 'new', locals: { investigation: @investigation, investigation_officers: @investigation_officers }
      end
    end
  end

  def terminate
    @assignment = Assignment.find(params[:id])
    @assignment.end_date = Date.current
    @assignment.save
    redirect_to officer_path(@assignment.officer)
  end

  private
  def assignment_params
    params.require(:assignment).permit(:investigation_id, :officer_id, :start_date, :end_date)
  end
end
