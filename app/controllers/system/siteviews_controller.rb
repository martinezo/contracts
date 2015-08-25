class System::SiteviewsController < ApplicationController
  before_action :set_system_siteview, only: [:show, :edit, :update, :destroy]

  # GET /system/siteviews
  # GET /system/siteviews.json
 def index
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    if params[:codigo].nil? || params[:codigo].empty?
      @system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 2)
    else
            @system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 2)

      #@catalogs_siteviews = Catalogs::Siteview.where("visit_date LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
    end
  end

  # GET /system/siteviews/1
  # GET /system/siteviews/1.json
  def show
  end

  # GET /system/siteviews/new
  def new
    @system_siteview = System::Siteview.new
  end

  # GET /system/siteviews/1/edit
  def edit
  end

  # POST /system/siteviews
  # POST /system/siteviews.json
  def create
    @system_siteview = System::Siteview.new(system_siteview_params)
	visit=System::Siteview.find(system_siteview_params[:contract_id])
	@recordar=Time.new(*params["recordar"].values.map(&:to_i))

	@email=visit.contract.supplier.email
	#Notifier.delay(run_at: 5.minutes.from_now).signup(@user)
	puts 'AKI DEBE IR EL PARAMETRO RECORDAR ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
	puts @recordar
	puts 'AKI VA EL CAMPO NOW TIME ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
	puts Time.now
	puts 'AKI TERMINA IR EL PARAMETRO EMAIL ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
    respond_to do |format|
      if @system_siteview.save
	ApplicationMailer.delay(run_at: @recordar).send_mail(@email)
        format.html { redirect_to @system_siteview, notice: 'Siteview was successfully created.' }
        format.json { render :show, status: :created, location: @system_siteview }
      else
        format.html { render :new }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system/siteviews/1
  # PATCH/PUT /system/siteviews/1.json
  def update
    respond_to do |format|
      if @system_siteview.update(system_siteview_params)
        format.html { redirect_to @system_siteview, notice: 'Siteview was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_siteview }
      else
        format.html { render :edit }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system/siteviews/1
  # DELETE /system/siteviews/1.json
  def destroy
    @system_siteview.destroy
    respond_to do |format|
      format.html { redirect_to system_siteviews_url, notice: 'Siteview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_siteview
      @system_siteview = System::Siteview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_siteview_params
      params.require(:system_siteview).permit(:contract_id, :visit_date, :completed)
    end
end
