class CrimesController < ApplicationController
  before_action :check_login
  
  
  def index
    @active_crimes = Crime.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_crimes = Crime.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def new
    @crime = Crime.new
  end

  def edit
    @crime = Crime.find(params[:id])
  end

  def create
    @crime = Crime.new(crime_params)
    if @crime.save
      redirect_to crimes_path, notice: "Successfully added #{@crime.name} to GCPD."
    else
      render action: 'new'
    end
  end

  def update
    @crime = Crime.find(params[:id])
    respond_to do |format|
      if @crime.update_attributes(crime_params)
        format.html { redirect_to @crime, notice: "Updated information" }

      else
        format.html { render :action => "edit" }

      end
    end
  end



  private
  def crime_params
    params.require(:crime).permit(:name, :felony, :active)
  end
end
