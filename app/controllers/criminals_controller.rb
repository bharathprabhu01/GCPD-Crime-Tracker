class CriminalsController < ApplicationController
  before_action :check_login
  before_action :set_criminal, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    @criminals = Criminal.alphabetical.paginate(page: params[:page]).per_page(10)
    bool_enhanced, bool_felon = nil, nil
    # set boolean values to filter index page
    if(params[:enhanced_filter].nil? == false) 
      if(params[:enhanced_filter] == "Yes" ? bool_enhanced = true : bool_enhanced = false)
      end
    end
    if(params[:felon_filter].nil? == false) 
      if(params[:felon_filter] == "Yes" ? bool_felon = true : bool_felon = false)
      end
    end
    
    # set @criminals based on boolean values
    if((bool_enhanced.nil? == false) and bool_felon.nil?)
      @criminals = Criminal.where(enhanced_powers: bool_enhanced).alphabetical.paginate(page: params[:page]).per_page(10)
    elsif((bool_felon.nil? == false) and bool_enhanced.nil?)
      @criminals = Criminal.where(convicted_felon: bool_felon).alphabetical.paginate(page: params[:page]).per_page(10)
    elsif((bool_felon.nil? == false) and (bool_enhanced.nil? == false))
      @criminals = Criminal.where(enhanced_powers: bool_enhanced, convicted_felon: bool_felon).alphabetical.paginate(page: params[:page]).per_page(10)
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
  
  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @criminals = Criminal.search(@query)
    if(@criminals.size == 1)
      redirect_to @criminals.first
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
