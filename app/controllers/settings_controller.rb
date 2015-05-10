class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    @settings = Setting.all
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to [:admin, @setting], notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @setting] }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to [:admin, @setting], notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @setting] }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    respond_to do |format|
      if current_user.admin? && @setting.destroy
        format.html { redirect_to admin_settings_url, notice: 'Setting was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_settings_url, alert: 'Only administrators can delete settings.' }
        format.json { render json: {admin_required: 'Only administrators can delete settings.'}, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:name, :desc, :value)
    end
end
