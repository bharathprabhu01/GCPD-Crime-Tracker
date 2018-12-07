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
    @note = InvestigationNote.find(params[:id])
  end

  def create
    @note = InvestigationNote.new(investigation_note_params)
    @note.date = Date.current
    byebug
    if @note.save
      redirect_to investigation_path(@note.investigation), notice: "Successfully added note to #{@note.investigation.title}"
    else
      @investigation = Investigation.find(params[:investigation_note][:investigation_id])
      @officer = Officer.find(params[:investigation_note][:officer_id])
      render action: 'new', locals: { investigation: @investigation, officer: @officer }
    end 
  end

  def update
    @note = InvestigationNote.find(params[:id])
    respond_to do |format|
      if @note.update_attributes(investigation_note_params)
        format.html { redirect_to @note.investigation, notice: "Updated note for #{@note.investigation.title}" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  def investigation_note_params
    params.require(:investigation_note).permit(:investigation_id, :officer_id, :content, :date)
  end
end
