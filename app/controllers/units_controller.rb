class UnitsController < ApplicationController
  before_action :check_login
  authorize_resource
  
  def index
    @active_units = Unit.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_units = Unit.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def show
    @unit = Unit.find(params[:id])
    @officers = @unit.officers.active.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def new
    @unit = Unit.new
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to units_path, notice: "Successfully added #{@unit.name} to GCPD."
    else
      render action: 'new'
    end
  end

  def update
    @unit = Unit.find(params[:id])
    respond_to do |format|
      if @unit.update_attributes(unit_params)
        format.html { redirect_to @unit, notice: "Updated information" }
        format.json { respond_with_bip(@unit) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@unit) }
      end
    end
  end
  
  def destroy
    @unit = Unit.find(params[:id])
    if @unit.destroy
      redirect_to units_path, notice: "Successfully removed #{@unit.name} from GCPD."
    else
      @officers = @unit.officers.active.alphabetical.paginate(page: params[:page]).per_page(10)
      render action: 'show'
    end
  end

  private
  def unit_params
    params.require(:unit).permit(:name, :active)
  end
end
