class InvestigationsController < ApplicationController
  before_action :set_investigation, only: [:show, :edit, :update, :close, :crimes]
  before_action :check_login
  
  authorize_resource

  def index
    @open_investigations = Investigation.is_open.chronological.paginate(page: params[:page]).per_page(10)
    @closed_investigations = Investigation.is_closed.chronological.paginate(page: params[:page]).per_page(10)
    @closed_unsolved = Investigation.is_closed.unsolved.chronological.to_a.reverse.take(5)
    @with_batman = Investigation.with_batman.chronological.to_a.reverse.take(5)
  end

  def show
    @current_assignments = @investigation.assignments.current.by_officer
    @current_suspects = @investigation.suspects.current.alphabetical.to_a
    @previous_suspects = @investigation.suspects.alphabetical.to_a - @current_suspects
    @case_crimes = @investigation.crimes.alphabetical.to_a
    @officer = Officer.new
    @notes = @investigation.investigation_notes.chronological
  end

  def new
    @investigation = Investigation.new
  end

  def edit
  end

  def create 
    @investigation = Investigation.new(investigation_params)
    if @investigation.save
      redirect_to investigations_path, notice: "Successfully added #{@investigation.title} to GCPD."
    else
      render action: 'new'
    end
  end

  def update
    @investigation = Investigation.find(params[:id])
    respond_to do |format|
      if @investigation.update_attributes(investigation_params)
        format.html { redirect_to @investigation, notice: "Updated information" }
        # format.json { respond_with_bip(@investigation) }
      else
        format.html { render :action => "edit" }
        # format.json { respond_with_bip(@investigation) }
      end
    end
  end
  
  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @investigations = Investigation.title_search(@query)
    if(@investigations.size == 1)
      redirect_to @investigations.first
    end
  end

  private
  def set_investigation
    @investigation = Investigation.find(params[:id])
  end

  def investigation_params
    params.require(:investigation).permit(:title, :description, :crime_location, :date_opened, :date_closed, :solved, :batman_involved)
  end
end
