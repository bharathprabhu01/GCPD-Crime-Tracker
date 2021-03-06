class OfficersController < ApplicationController
  before_action :set_officer, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource


  def index
    @active_officers = Officer.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_officers = Officer.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def show
    print(@officer.errors.messages)
    @current_assignments = @officer.assignments.current.chronological
    @past_assignments = @officer.assignments.past.chronological
  end

  def new
    @officer = Officer.new
  end

  def edit
    @user = @officer.user
  end

  def create
    @officer = Officer.new(officer_params)
    @user = User.new(user_params)
    @user.active = true
    if !@user.save
      @officer.valid?
      flash[:error] = @user.errors.full_messages.first
      render action: 'new'
    
    # user can be saved, so try saving the officer
    else
      @officer.user_id = @user.id
      if @officer.save
        flash[:notice] = "Successfully created #{@officer.proper_name}."
        redirect_to officer_path(@officer) 
      else
        render action: 'new'
      end      
    end
  end

  def update
    @user = @officer.user
    respond_to do |format|
      if @officer.update_attributes(officer_params) and @user.update_attributes(user_params)
        format.html { redirect_to @officer, notice: "Updated all officer information" }
        format.json { respond_with_bip(@officer) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@officer) }
      end
    end
  end
  
  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @officers = Officer.search(@query)
    if(@officers.size == 1)
      redirect_to @officers.first
    end
  end
  
  def destroy
    if @officer.destroy
      @officer.user.destroy
      redirect_to officers_path, notice: "Successfully removed #{@officer.proper_name} from GCPD."
    else
      @current_assignments = @officer.assignments.current.chronological
      @past_assignments = @officer.assignments.past.chronological
      render action: 'show'
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_officer
    @officer = Officer.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def officer_params
    params.require(:officer).permit(:first_name, :last_name, :rank, :ssn, :active, :unit_id, :username, :password, :password_confirmation)
  end
  
  def user_params      
    params.require(:officer).permit(:username, :role, :active, :password, :password_confirmation)
  end
  
end
