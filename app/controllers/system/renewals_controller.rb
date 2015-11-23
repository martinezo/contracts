class System::RenewalsController < ApplicationController
  before_action :set_system_renewal, only: [:show, :edit, :update, :destroy]

  # GET /system/renewals
  # GET /system/renewals.json
  def index
    @aux = 'notnil'
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
    @contract_id = params[:contract_id]
    @system_renewal = System::Renewal.new
    @eureka = nil
  end

  # GET /system/renewals/1/edit
  def edit
    @eureka = 'notnil'
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /system/renewals
  # POST /system/renewals.json
  def create
	
        #ESTO SE VA DESCOMENTAR CUANDO SE INSERTE EL START_DATE Y EL END_DATE DEL FORMULARIO DE RENEWAL
        puts 'Aki va el array de Renewal'
        puts system_renewal_params
        puts 'Aki termina el arrayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
        contract = System::Contract.find(system_renewal_params[:contract_id])
        @email = contract.supplier.email
        @start_date=Date.new(system_renewal_params["start_date(1i)"].to_i,system_renewal_params["start_date(2i)"].to_i,system_renewal_params["start_date(3i)"].to_i)
        @end_date=Date.new(system_renewal_params["end_date(1i)"].to_i,system_renewal_params["end_date(2i)"].to_i,system_renewal_params["end_date(3i)"].to_i)
		t0=Time.new(system_renewal_params["start_date(1i)"].to_i,system_renewal_params["start_date(2i)"].to_i,system_renewal_params["start_date(3i)"].to_i)
        t1=Time.new(system_renewal_params["end_date(1i)"].to_i,system_renewal_params["end_date(2i)"].to_i,system_renewal_params["end_date(3i)"].to_i)
              
	   puts 'Aki va el parametro start_date sssssssssssssssssssssssssssssssssss'
        puts t1
        @recordar = t0 - APP_CONFIG["production"][:notification_time].to_i.days # resta 1 semana
        @recordar2 = t1 - APP_CONFIG["production"][:notification_time].to_i.days
        puts 'aki va el recordatorio al iniciar la renovacion'
        puts @recordar
        puts 'aki terminaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        puts @email
		
 
	@start_date_google=system_renewal_params["start_date(1i)"].to_s + '-' + system_renewal_params["start_date(2i)"].to_s + '-' + system_renewal_params["start_date(3i)"].to_s + 'T10:00:52-05:00'
	@end_date_google=system_renewal_params["end_date(1i)"].to_s + '-' + system_renewal_params["end_date(2i)"].to_s + '-' + system_renewal_params["end_date(3i)"].to_s + 'T10:00:52-05:00'
	@x=System::Contract.find(system_renewal_params[:contract_id])
	@google_event_start = System::Renewal.event_insert(@start_date_google,@start_date_google,@x.description,'neuro')
    @google_event_end= System::Renewal.event_insert(@end_date_google,@end_date_google,@x.description,'neuro')

	@system_renewal = System::Renewal.new(contract_id: system_renewal_params[:contract_id], start_date: @start_date, end_date: @end_date, monto: system_renewal_params[:monto], google_event_start: @google_event_start, google_event_end: @google_event_end)

    respond_to do |format|
      if @system_renewal.save
	    
        ApplicationMailer.delay(run_at: @recordar).send_mail(@email, @x)
        ApplicationMailer.delay(run_at: @recordar2).send_mail(@email, @x)
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
  		@start_date=Date.new(system_renewal_params["start_date(1i)"].to_i,system_renewal_params["start_date(2i)"].to_i,system_renewal_params["start_date(3i)"].to_i)
        @end_date=Date.new(system_renewal_params["end_date(1i)"].to_i,system_renewal_params["end_date(2i)"].to_i,system_renewal_params["end_date(3i)"].to_i)
		
		@start_date_google=system_renewal_params["start_date(1i)"].to_s + '-' + system_renewal_params["start_date(2i)"].to_s + '-' + system_renewal_params["start_date(3i)"].to_s + 'T10:00:52-05:00'
		@end_date_google=system_renewal_params["end_date(1i)"].to_s + '-' + system_renewal_params["end_date(2i)"].to_s + '-' + system_renewal_params["end_date(3i)"].to_s + 'T10:00:52-05:00'
	
		x=System::Contract.find(system_renewal_params[:contract_id])
		puts 'aki va el ID del calendariooooooooooooooooooooooooooooooooooooooooo'
		puts System::Renewal.find(params[:id]).google_event_start
		puts 'aki termina el ID del calendariooooooooooooooooooooooooooooooooooooooooo'
		System::Renewal.event_update(@start_date_google,@start_date_google,x.description,'neuro',System::Renewal.find(params[:id]).google_event_start)
		System::Renewal.event_update(@end_date_google,@end_date_google,x.description,'neuro',System::Renewal.find(params[:id]).google_event_end)

    respond_to do |format|
      if @system_renewal.update(contract_id: system_renewal_params[:contract_id], start_date: @start_date, end_date: @end_date, monto: system_renewal_params[:monto])
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
    System::Renewal.event_delete_cascade_renewal(@system_renewal.id)
    puts 'AKI VA EL ID DE LA RENOVACION QUE SE ESTA ELIMINANDO-||||||||||||||||||||||||||||||||||||||||'
    puts @system_renewal.destroy
     puts 'AKI VA EL ID DE LA RENOVACION QUE SE ESTA ELIMINANDO-|||||||||||||||||||||||||||||||||||||||'
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
      params.require(:system_renewal).permit(:contract_id, :start_date, :end_date, :monto)
    end
end
