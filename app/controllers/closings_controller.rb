class ClosingsController < ApplicationController
  before_action :set_closing, only: [:update, :destroy]

  # POST /closings
  # POST /closings.json
  def create
    @closing = Closing.new(closing_params)

    respond_to do |format|
      if @closing.save
        format.json { render :show, status: :created, location: [:admin, @closing] }
      else
        format.json { render json: @closing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /closings/1
  # PATCH/PUT /closings/1.json
  def update
    respond_to do |format|
      if @closing.update(closing_params)
        format.json { render :show, status: :ok, location: [:admin, @closing] }
      else
        format.json { render json: @closing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /closings/1
  # DELETE /closings/1.json
  def destroy
    @closing.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closing
      @closing = Closing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def closing_params
      params.require(:closing).permit(:date, :all_day, :desc, :duration)
    end
end
