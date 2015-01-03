class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:profile, :update_profile]

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/profile
  # GET /users/profile.json
  def profile
    @user = current_user
    render :show
  end

  def update_profile
    @user = current_user
    update
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if current_user.patient? && user_params[:current_password].blank?
        @user.errors.add(:current_password, 'cannot be blank')
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif current_user.patient? && @user.update_with_password(user_params) || current_user.admin_or_staff? && @user.update_without_password(user_params)
        if current_user.admin_or_staff?
          format.html { redirect_to admin_user_url(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: admin_user_url(@user) }
        else
          format.html { redirect_to root_path, notice: 'Your profile was successfully updated.' }
          format.json { render :show, status: :ok, location: profile_url }
        end
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if current_user.admin_or_staff?
        params.require(:user).permit(:email, :gender, :dob, :password, :password_confirmation, :first, :middle, :last)
      elsif current_user.patient? && action_name == 'update_profile'
        params.require(:user).permit(:email, :current_password, :gender, :dob, :password, :password_confirmation, :first, :middle, :last)
      end
    end
end
