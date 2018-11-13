class AssignmentsController < ApplicationController
  before_action :check_login


  def new
    @assignment = Assignment.new
    unless params[:officer_id].nil?
      @officer    = Officer.find(params[:officer_id])
      @officer_investigations = @officer.assignments.current.map{|a| a.investigation }
    end

  end
  
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.start_date = Date.current
    if @assignment.save
      flash[:notice] = "Successfully added assignment."
      redirect_to officer_path(@assignment.officer)

    else
      @officer     = Officer.find(params[:assignment][:officer_id])
      render action: 'new', locals: { officer: @officer }
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
