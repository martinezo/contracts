class System::RenewalsController < ApplicationController
  before_action :set_system_renewal, only: [:show, :edit, :update, :destroy]

  # GET /system/renewals
  # GET /system/renewals.json
  def index
    if admin_signed_in?
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
      if params[:codigo].nil? || params[:codigo].empty?
        @system_renewals = System::Renewal.all.paginate(page: params[:page], per_page: 10)
      else
        @system_renewals = System::Renewal.all.paginate(page: params[:page], per_page: 10)
      end
    else
      redirect_to new_admin_session_path
    end
  end

  # GET /system/renewals/1
  # GET /system/renewals/1.json
  def show
  end

  # GET /system/renewals/new
  def new
    @system_renewal = System::Renewal.new
  end

  # GET /system/renewals/1/edit
  def edit
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /system/renewals
  # POST /system/renewals.json
  def create
    @system_renewal = System::Renewal.new(system_renewal_params)

    respond_to do |format|
      if @system_renewal.save
        format.html { redirect_to @system_renewal, notice: 'Renewal was successfully created.' }
        format.json { render :show, status: :created, location: @system_renewal }
        format.js { redirect_to @system_renewal, notice: 'Renewal was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @system_renewal.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /system/renewals/1
  # PATCH/PUT /system/renewals/1.json
  def update
    respond_to do |format|
      if @system_renewal.update(system_renewal_params)
        format.html { redirect_to @system_renewal, notice: 'Renewal was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_renewal }
        format.js   { redirect_to @system_renewal, notice: 'Renewal was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @system_renewal.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /system/renewals/1
  # DELETE /system/renewals/1.json
  def destroy
    @system_renewal.destroy
    respond_to do |format|
      format.html { redirect_to system_renewals_url, notice: 'Renewal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_renewal
      @system_renewal = System::Renewal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_renewal_params
      params.require(:system_renewal).permit(:contract_id, :start_date, :end_date)
    end
end
