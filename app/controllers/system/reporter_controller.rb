class System::ReporterController < ApplicationController
  def index
	@renewals=System::Renewal.all
	@system_renewals = Array.new()
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
			end
		end
	end
	
  end
end
