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
      flash[:notice] = "Successfully added #{@user.proper_name} as a user."
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.proper_name}."
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "Successfully removed #{@user.proper_name} from the PATS system."
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
