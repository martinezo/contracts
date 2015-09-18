class System::SiteviewsController < ApplicationController
  before_action :set_system_siteview, only: [:show, :edit, :update, :destroy]

  # GET /system/siteviews
  # GET /system/siteviews.json
 def index
 if admin_signed_in?
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    if params[:codigo].nil? || params[:codigo].empty?
      @system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 10)
    else
            @system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 10)

      #@catalogs_siteviews = Catalogs::Siteview.where("visit_date LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
    end
	else
	redirect_to new_admin_session_path
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

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /system/siteviews
  # POST /system/siteviews.json
  def create
	    @system_siteview = System::Siteview.new(system_siteview_params)
            renewal=System::Renewal.find(system_siteview_params[:renewal_id])
            format=*params["recordar"].values.map(&:to_i)
            @recordar=Time.new(format[2],format[1],format[0],format[3],format[4])
            @email=renewal.contract.supplier.email
            puts 'AKI DEBE IR EL PARAMETRO RECORDAR ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts @recordar
            puts 'AKI VA EL CAMPO NOW TIME ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts Time.now
            puts 'AKI TERMINA IR EL PARAMETRO EMAIL ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts @email

respond_to do |format|
    if @system_siteview.save
	ApplicationMailer.delay(run_at: @recordar).send_mail(@email)
        format.html { redirect_to @system_siteview, notice: t('.created') }
        format.json { render :show, status: :created, location: @system_siteview }
        format.js   { redirect_to @system_siteview, notice: t('.created') }
      else
        format.html { render :new }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /system/siteviews/1
  # PATCH/PUT /system/siteviews/1.json
  def update
    respond_to do |format|
      if @system_siteview.update(system_siteview_params)
        format.html { redirect_to @system_siteview, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @system_siteview }
      else
        format.html { render :edit }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /system/siteviews/1
  # DELETE /system/siteviews/1.json
  def destroy
    @system_siteview.destroy
    respond_to do |format|
      format.html { redirect_to system_siteviews_url, notice: t('.destroyed') }
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
      params.require(:system_siteview).permit(:renewal_id, :visit_date, :completed)
    end
end
