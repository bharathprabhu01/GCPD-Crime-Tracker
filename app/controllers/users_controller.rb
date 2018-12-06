class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
  end

  def new
    @user = User.new
  end

  def edit
    @user.role = "commish" if current_user.role?(:commish)
  end

  def create
    @user = User.new(user_params)
    @user.role = "commish" if current_user.role?(:commish)
    if @user.save
      flash[:notice] = "Successfully added #{@user.officer.proper_name} as a user."
      redirect_to officer_path(@user.officer)
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated user information for #{@user.officer.proper_name}"
      redirect_to officer_path(@user.officer)
    else
      flash[:error] = "Unable to update user, please check password (must be at least 4 characters long)"
      redirect_to edit_officer_path(@user.officer)
    end
  end

  def destroy
    if @user.destroy
      redirect_to officers_path, notice: "Successfully removed #{@user.officer.proper_name} from the system."
    else
      redirect_to @user.officer
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :role, :active, :password, :password_confirmation)
    end

end
