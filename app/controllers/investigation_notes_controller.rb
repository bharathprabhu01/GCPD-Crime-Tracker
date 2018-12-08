class InvestigationNotesController < ApplicationController
  before_action :check_login
  authorize_resource
  
  def index
  end

  def new
    @note = InvestigationNote.new
    @investigation    = Investigation.find(params[:investigation_id])
    @officer = Officer.find(params[:officer_id])
  end

  def edit
  end

  def create
    @note = InvestigationNote.new(investigation_note_params)
    @note.date = Date.current
    if @note.save
      redirect_to investigation_path(@note.investigation), notice: "Successfully added note to #{@note.investigation.title}"
    else
      @investigation = Investigation.find(params[:investigation_note][:investigation_id])
      @officer = Officer.find(params[:investigation_note][:officer_id])
      render action: 'new', locals: { investigation: @investigation, officer: @officer }
    end 
  end

  def update
  end

  private
  def investigation_note_params
    params.require(:investigation_note).permit(:investigation_id, :officer_id, :content, :date)
  end
end
