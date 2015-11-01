class System::ContractsController < ApplicationController
  before_action :set_system_contract, only: [:show, :edit, :update, :destroy]

  # GET /system/contracts
  # GET /system/contracts.json
  def index
    @aux = 'notnil'
    if admin_signed_in?
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
      if params[:codigo].nil? || params[:codigo].empty?
        @system_contracts = System::Contract.all.paginate(page: params[:page], per_page: 10)      
      else    
        @system_contracts= System::Contract.where("contract_no LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 10)
      end
  	else
  	  redirect_to new_admin_session_path
    end
  end

  # GET /system/contracts/1
  # GET /system/contracts/1.json
  def show
    @contract=System::Contract.find(@system_contract.id)
    @contract.Renewals.each do |renewal|
      if renewal.vigencia == :active or renewal.vigencia == :to_expire
        @active_renewal = renewal           
      end
    end
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = ReportPDF.new(@system_contract)
        send_data pdf.render, filename: "PDF Test.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /system/contracts/new
  def new
    @system_contract = System::Contract.new
    @system_renewal = System::Renewal.new
    @system_renewal.monto = 0
    @eureka = nil
  end

  # GET /system/contracts/1/edit
  def edit
    @system_renewal = System::Renewal.find(@system_contract.Renewals.sort_by{ |hsh| hsh[:start_date] }.last)
    @system_contract.start_date=@system_renewal.start_date
	@eureka = 'notnil'
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /system/contracts
  # POST /system/contracts.json
  def create
    	@system_contract = System::Contract.new(system_contract_params)
	# INERTAR UN NUEVO RENEWAL DE FORMA AUTOMATICA
        format1=*params["start_date"].values.map(&:to_i)
	@start_date=Date.new(format1[2],format1[1],format1[0])

        format2=*params["end_date"].values.map(&:to_i)
	@end_date=Date.new(format2[2],format2[1],format2[0])

	@start_date_google=format1[2].to_s + '-' + format1[1].to_s + '-' + format1[0].to_s + 'T10:00:52-05:00'
	@end_date_google=format2[2].to_s + '-' + format2[1].to_s + '-' + format2[0].to_s + 'T10:00:52-05:00'

		
	#ESTO SE VA DESCOMENTAR CUANDO SE INSERTE EL START_DATE Y EL END_DATE DEL FORMULARIO DE RENEWAL
	supplier = Catalogs::Supplier.find(system_contract_params[:supplier_id])
	@email = supplier.email
	#t0=Time.new(system_renewal_params["start_date(1i)"].to_i,system_renewal_params["start_date(2i)"].to_i,system_renewal_params["start_date(3i)"].to_i)
  #t1=Time.new(system_renewal_params["end_date(1i)"].to_i,system_renewal_params["end_date(2i)"].to_i,system_renewal_params["end_date(3i)"].to_i)
  puts 'Aki va el parametro start_date sssssssssssssssssssssssssssssssssss'
  #puts t1
  if params[:notification_date].nil? || params[:notification_date].empty?
    @recordar = @start_date - APP_CONFIG["production"][:notification_time].to_i.days # resta 1 semana
  else 
    @recordar = @start_date - params[:notification_date].to_i.days
 end
  @recordar2 = @end_date - APP_CONFIG["production"][:notification_time].to_i.days
  puts 'aki va el recordatorio al iniciar la renovacion'
  puts @recordar
  puts 'aki terminaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  puts @email

    respond_to do |format|
      if @system_contract.save
        @google_event_start = System::Renewal.event_insert(@start_date_google,@start_date_google,system_contract_params[:description],'neuro')
		@google_event_end= System::Renewal.event_insert(@end_date_google,@end_date_google,system_contract_params[:description],'neuro')

        @system_renewal=System::Renewal.new(contract_id: @system_contract.id, start_date: @start_date, end_date: @end_date, monto: params[:monto], google_event_start: @google_event_start, google_event_end: @google_event_end)
		puts 'google_event aki es'
		puts @google_event_start
		puts @google_event_end

	    puts 'google_event aki terminar'
	   if  @system_renewal.save
        ApplicationMailer.delay(run_at: @recordar).send_mail(@email)
        ApplicationMailer.delay(run_at: @recordar2).send_mail(@email) 
        format.html { redirect_to @system_contract, notice: t('.created') }
        format.json { render :show, status: :created, location: @system_contract }
        format.js   { redirect_to @system_contract, notice: t('.created') }
       else
	System::Contract.find(@system_contract.id).destroy
	end        
      else
        format.html { render :new }
        format.json { render json: @system_contract.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /system/contracts/1
  # PATCH/PUT /system/contracts/1.json
  def update
    respond_to do |format|
      if @system_contract.update(system_contract_params)

        format1=*params["start_date"].values.map(&:to_i)
  @start_date=Date.new(format1[2],format1[1],format1[0])

        format2=*params["end_date"].values.map(&:to_i)
  @end_date=Date.new(format2[2],format2[1],format2[0])
        var = @system_contract.Renewals.sort_by{ |hsh| hsh[:start_date] }.last
		
		@start_date_google=format1[2].to_s + '-' + format1[1].to_s + '-' + format1[0].to_s + 'T10:00:52-05:00'
		@end_date_google=format2[2].to_s + '-' + format2[1].to_s + '-' + format2[0].to_s + 'T10:00:52-05:00'

		system_renewal_params={:contract_id => @system_contract.id,:start_date => @start_date,:end_date => @end_date,:monto => params[:monto]}
        System::Renewal.find(var).update(system_renewal_params)
	  	System::Renewal.event_update(@start_date_google,@start_date_google,system_contract_params[:description],'neuro',System::Renewal.find(var).google_event_start)
		System::Renewal.event_update(@end_date_google,@end_date_google,system_contract_params[:description],'neuro',System::Renewal.find(var).google_event_end)
        system_renewal_params={:contract_id => @system_contract.id,:start_date => @start_date,:end_date => @end_date,:monto => params[:monto]}
        System::Renewal.find(var).update(system_renewal_params)


        format.html { redirect_to @system_contract, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @system_contract }
      else
        format.html { render :edit }
        format.json { render json: @system_contract.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /system/contracts/1
  # DELETE /system/contracts/1.json
  def destroy
    @system_contract.destroy
    respond_to do |format|
      format.html { redirect_to system_contracts_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_contract
      @system_contract = System::Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_contract_params
      params.require(:system_contract).permit(:device_id, :supplier_id, :start_date, :end_date, :contract_no, :description, :monto)
    end
end
