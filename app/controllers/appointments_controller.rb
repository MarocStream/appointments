class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    scope = Appointment.includes(:user, :appointment_type)
    if params[:start] && params[:duration]
      scope = scope.for_period(Date.parse(params[:start]), params[:duration].to_i)
    else
      scope = scope.all
    end
    @appointments = scope.to_a.map! do |appointment|
      unless allows_access?(appointment)
        appointment.user = nil
      end
      appointment
    end
    respond_to do |format|
      format.json
      format.html
      format.csv do
        filename = params[:start] && params[:duration] ? "appointments-#{params[:start]}-#{params[:duration]}.csv" : "appointments-latest.csv"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
        render :index
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
    @appointment.allow_conflict! if current_user.try(:admin_or_staff?)
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
      @appointment.allow_conflict! if current_user.try(:admin_or_staff?)
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
      @appointment = Appointment.includes(:user, :appointment_type).find(params[:id])
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
      unless allows_access?(@appointment)
        respond_to do |format|
          message = 'You may only access your own appointments.'
          format.html { redirect_to root_path, alert: message}
          format.json { render json: {errors: {appointment_access: message}}}
        end
      end
    end

    def allows_access?(appointment)
      # Logged in  &&  (      owned by current user      &&       patient        ||    admin or staff)
      current_user && (appointment.user == current_user && current_user.patient? || current_user.admin_or_staff?)
    end
end
