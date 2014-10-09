class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.includes(:user, :appointment_type).all.to_a.map! do |appointment|
      if cannot_access?(appointment)
        appointment.user = nil
        appointment
      else
        appointment
      end
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show

  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.includes(:user, :appointment_type).for_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      if current_user.nil? || current_user.patient?
        user_id = current_user.try(:id) ? current_user.id.to_s : nil # Keep id as a string or nil
        params.require(:appointment).permit(:start, :appointment_type_id).merge!(user_id: user_id)
      else
        params.require(:appointment).permit(:user_id, :start, :appointment_type_id)
      end
    end

    def check_access
      if cannot_access?(@appointment)
        respond_to do |format|
          message = 'You may only access your own appointments.'
          format.html { redirect_to root_path, alert: message}
          format.json { render json: {errors: {appointment_access: message}}}
        end
      end
    end

    def cannot_access?(appointment)
      current_user.nil? || (appointment.user != current_user && current_user.patient?)
    end
end
