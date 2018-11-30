class CriminalsController < ApplicationController
  before_action :check_login
  before_action :set_criminal, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    # Filter by power status
    if(params[:enhanced_filter] == nil)
      @criminals = Criminal.alphabetical.paginate(page: params[:page]).per_page(10)
      
    elsif(params[:enhanced_filter] == "Yes")
      @criminals = Criminal.enhanced.alphabetical.paginate(page: params[:page]).per_page(10)
      
    else
      @criminals = Criminal.where(enhanced_powers: false).alphabetical.paginate(page: params[:page]).per_page(10)
    end
  end

  def new
    @criminal = Criminal.new
  end

  def edit
  end

  def create
    @criminal = Criminal.new(criminal_params)
    if @criminal.save
      redirect_to criminals_path, notice: "Successfully added #{@criminal.name} to GCPD."
    else
      render action: 'new'
    end
  end
  
  def show
    @cases = @criminal.investigations.alphabetical.to_a
  end

  def update
    respond_to do |format|
      if @criminal.update_attributes(criminal_params)
        format.html { redirect_to @criminal, notice: "Updated information" }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    if @criminal.destroy
      redirect_to criminals_path, notice: "Successfully removed #{@criminal.name} from GCPD."
    else
      @cases = @criminal.investigations.alphabetical.to_a
      render action: 'show'
    end
  end
 
  private
  def set_criminal
    @criminal = Criminal.find(params[:id])
  end
  
  def criminal_params
    params.require(:criminal).permit(:first_name, :last_name, :aka, :convicted_felon, :enhanced_powers, :notes)
  end
end
