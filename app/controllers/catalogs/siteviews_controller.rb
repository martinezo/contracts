class Catalogs::SiteviewsController < ApplicationController
  before_action :set_catalogs_siteview, only: [:show, :edit, :update, :destroy]

  # GET /catalogs/siteviews
  # GET /catalogs/siteviews.json
   def index
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    if params[:codigo].nil? || params[:codigo].empty?
      @catalogs_siteviews = Catalogs::Siteview.all.paginate(page: params[:page], per_page: 2)
    else
            @catalogs_siteviews = Catalogs::Siteview.all.paginate(page: params[:page], per_page: 2)

      #@catalogs_siteviews = Catalogs::Siteview.where("visit_date LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
    end
  end

  # GET /catalogs/siteviews/1
  # GET /catalogs/siteviews/1.json
  def show
  end

  # GET /catalogs/siteviews/new
  def new
    @catalogs_siteview = Catalogs::Siteview.new
  end

  # GET /catalogs/siteviews/1/edit
  def edit
  end

  # POST /catalogs/siteviews
  # POST /catalogs/siteviews.json
  def create
    @catalogs_siteview = Catalogs::Siteview.new(catalogs_siteview_params)

    respond_to do |format|
      if @catalogs_siteview.save
        format.html { redirect_to @catalogs_siteview, notice: 'Siteview was successfully created.' }
        format.json { render :show, status: :created, location: @catalogs_siteview }
      else
        format.html { render :new }
        format.json { render json: @catalogs_siteview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalogs/siteviews/1
  # PATCH/PUT /catalogs/siteviews/1.json
  def update
    respond_to do |format|
      if @catalogs_siteview.update(catalogs_siteview_params)
        format.html { redirect_to @catalogs_siteview, notice: 'Siteview was successfully updated.' }
        format.json { render :show, status: :ok, location: @catalogs_siteview }
      else
        format.html { render :edit }
        format.json { render json: @catalogs_siteview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/siteviews/1
  # DELETE /catalogs/siteviews/1.json
  def destroy
    @catalogs_siteview.destroy
    respond_to do |format|
      format.html { redirect_to catalogs_siteviews_url, notice: 'Siteview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_siteview
      @catalogs_siteview = Catalogs::Siteview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogs_siteview_params
      params.require(:catalogs_siteview).permit(:contract_id, :visit_date, :completed)
    end
end
