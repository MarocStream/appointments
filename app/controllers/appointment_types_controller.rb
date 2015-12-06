class AppointmentTypesController < ApplicationController
  before_action :authenticate_user!, unless: :index
  before_action :require_admin!, unless: :index

  before_action :set_appointment_type, only: [:show, :edit, :update, :destroy]

  # GET /appointment_types
  # GET /appointment_types.json
  def index
    @appointment_types = AppointmentType.all
  end

  # GET /appointment_types/1
  # GET /appointment_types/1.json
  def show
  end

  # GET /appointment_types/new
  def new
    @appointment_type = AppointmentType.new
  end

  # GET /appointment_types/1/edit
  def edit
  end

  # POST /appointment_types
  # POST /appointment_types.json
  def create
    @appointment_type = AppointmentType.new(appointment_type_params)

    respond_to do |format|
      if @appointment_type.save
        format.html { redirect_to @appointment_type, notice: 'Appointment type was successfully created.' }
        format.json { render :show, status: :created, location: @appointment_type }
      else
        format.html { render :new }
        format.json { render json: @appointment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointment_types/1
  # PATCH/PUT /appointment_types/1.json
  def update
    respond_to do |format|
      if @appointment_type.update(appointment_type_params)
        format.html { redirect_to admin_appointment_types_path, notice: 'Appointment type was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment_type }
      else
        format.html { render :edit }
        format.json { render json: @appointment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_types/1
  # DELETE /appointment_types/1.json
  def destroy
    @appointment_type.destroy
    respond_to do |format|
      format.html { redirect_to appointment_types_url, notice: 'Appointment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_type
      @appointment_type = AppointmentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_type_params
      params.require(:appointment_type).permit(:name, :duration, :prep_duration, :post_duration, :color_class, :group, :group_time_per_person, :text_color)
    end
end
