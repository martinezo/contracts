class System::ContractsController < ApplicationController
  before_action :set_system_contract, only: [:show, :edit, :update, :destroy]

  # GET /system/contracts
  # GET /system/contracts.json
 def index
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    if params[:codigo].nil? || params[:codigo].empty?
      @system_contracts = System::Contract.all.paginate(page: params[:page], per_page: 2)
    else
      #@catalogs_suppliers.where(business_name: params[:codido])
      @system_contracts= System::Contract.where("contract_no LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
    end
  end


  # GET /system/contracts/1
  # GET /system/contracts/1.json
  def show
  end

  # GET /system/contracts/new
  def new
    @system_contract = System::Contract.new
  end

  # GET /system/contracts/1/edit
  def edit
  end

  # POST /system/contracts
  # POST /system/contracts.json
  def create
    @system_contract = System::Contract.new(system_contract_params)

    respond_to do |format|
      if @system_contract.save
        format.html { redirect_to @system_contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @system_contract }
      else
        format.html { render :new }
        format.json { render json: @system_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system/contracts/1
  # PATCH/PUT /system/contracts/1.json
  def update
    respond_to do |format|
      if @system_contract.update(system_contract_params)
        format.html { redirect_to @system_contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_contract }
      else
        format.html { render :edit }
        format.json { render json: @system_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system/contracts/1
  # DELETE /system/contracts/1.json
  def destroy
    @system_contract.destroy
    respond_to do |format|
      format.html { redirect_to system_contracts_url, notice: 'Contract was successfully destroyed.' }
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
      params.require(:system_contract).permit(:device_id, :supplier_id, :start_date, :end_date, :contract_no)
    end
end
