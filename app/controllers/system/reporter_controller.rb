class System::ReporterController < ApplicationController
  $pdf_var = System::Renewal.all
  def index
    @aux = nil
    
    @system_contract=System::Contract.all
    @catalog_supplier = Catalogs::Supplier.all
    @catalog_device = Catalogs::Device.all
    @renewals=System::Renewal.all    
    @catalog_renewals = @renewals
    @system_renewals = Array.new()
    params[:start_date] = nil
    #params[:contract_param_no] = nil
    #params[:device] = nil
    #params[:supplier] = nil

    respond_to do |format|
      format.html do
      if params[:start_date].nil? or params[:end_date].nil?
        if params[:contract_param_no].nil? or params[:contract_param_no].to_i == 0
          if params[:device].nil? or params[:device].to_i == 0
            if params[:supplier].nil? or params[:supplier].to_i ==0
              @system_renewals = @renewals
              $pdf_var = @system_renewals
            else
              puts "Supplieeeeer! #{params[:supplier].to_i}"
              contracts = System::Contract.where("supplier_id = '#{params[:supplier].to_i}'")
              contracts.each do |cntrct|
                rnwls = System::Renewal.where("contract_id = '#{cntrct.id.to_i}'")
                rnwls.each do |rnwl|
                  @system_renewals.insert(0,rnwl)
                end
              end 
              $pdf_var = @system_renewals
            end
          else
            puts "Deviceeeeeeeees!!!!#{params[:device]}"
            contracts = System::Contract.where("device_id = '#{params[:device].to_i}'")
            contracts.each do |cntrct|
              rnwls = System::Renewal.where("contract_id = '#{cntrct.id.to_i}'")
              rnwls.each do |rnwl|
                @system_renewals.insert(0,rnwl)
              end
            end
            $pdf_var = @system_renewals
          end
        else
          puts "What!!!!!!??????????????????????????? #{params[:contract_param_no].class}"
          var0 = System::Contract.find(params[:contract_param_no].to_i)
          @system_renewals = var0.Renewals
          $pdf_var = @system_renewals
        end
      else
        puts "fechaaaaaaaa! :o"
        format1=*params["start_date"].values.map(&:to_i)
        t0=Date.new(format1[2],format1[1],format1[0])
            format2=*params["end_date"].values.map(&:to_i)
        t1=Date.new(format2[2],format2[1],format2[0])
        @renewals.each do |renewal|
        if (renewal.date_filter(t0,t1) == :active)
          @system_renewals.insert(0,renewal)
        else

        end
        $pdf_var = @system_renewals
      end
    end
    end
     format.js
      format.pdf do
        puts "#{$pdf_var}"
        pdf = ReportPDF.new($pdf_var)
        send_data pdf.render, filename: "PDF Test.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def update_contracts
    if params[:device].nil?
      contract = Catalogs::Supplier.find(params[:supplier].to_i)
    else
      contract = Catalogs::Device.find(params[:device].to_i)
    end
    #@system_contract = contract.Contracts
  end

  def update_renewals
    puts "PAraaaaaammmmsssss!!!!!!!!!!!!!!!!!!!#{params[:contract_param_no].to_i}"
    renew = System::Contract.find(params[:contract_param_no].to_i)
    #puts "Deviceeeeeeeees!!!!#{contract.class}"
    #@catalog_device = System::Device.all.map{|e| [e.name, e.id]}.insert(0, "Seleccione equipo...")
    #@catalog_device = contract.device.map{|e| [e.name, e.id]}.insert(0, "Seleccione equipo...")
    #@catalog_device = contract.device
    @catalog_renewals = renew.Renewals
  end

  

end