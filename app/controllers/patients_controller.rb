class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  

  def index
    @patients = Patient.paginate(page: params[:page], per_page: 7)
    
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    @patient.user = current_user
    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    if params[:patient].present?
      @patient = Patient.search(params[:patient])
      if @patient
        respond_to do |format|
          format.js { render partial: 'patients/patient_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Could not find user!'
          format.js { render partial: 'patients/patient_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] ='Porfavor ingrese un codigo QR!'
        format.js { render partial: 'patients/patient_result'}
      end
    end
  end
  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :p_lastname, :m_lastname, :birth, :emergency_number, :phase, :hexa_code)
    end
end
