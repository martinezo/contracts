class System::ReporterController < ApplicationController
  def index
  	@system_contract=System::Contract.all
  	@catalog_device = Catalogs::Device.all
  	@catalog_supplier = Catalogs::Supplier.all
	  @renewals=System::Renewal.all
	  @system_renewals = Array.new()

  	respond_to do |format|
    	format.html do
			if params[:start_date].nil? or params[:end_date].nil?
				@system_renewals = @renewals
			else
				format1=*params["start_date"].values.map(&:to_i)
				t0=Date.new(format1[2],format1[1],format1[0])
        		format2=*params["end_date"].values.map(&:to_i)
				t1=Date.new(format2[2],format2[1],format2[0])
				@renewals.each do |renewal|
				if (renewal.date_filter(t0,t1) == :active)
					@system_renewals.insert(0,renewal)
				else

				end
			end
		end
    end
     format.js
      format.pdf do
        pdf = ReportPDF.new(@renewals)
        send_data pdf.render, filename: "PDF Test.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end
