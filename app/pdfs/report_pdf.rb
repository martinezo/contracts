class ReportPDF < Prawn::Document
	def initialize(report)
		super(
			:page_size => "A4", 
			:page_layout => :landscape, 
			:margin => 50 )
		@report = report
		report_number
		line_items
	end

	def report_number
		move_down 10
		font "Helvetica", :size => 16
		#text I18n.t('pdf.title_pdf') , :align => :center, :color => "FF0000"
		text "Reporte general de Contratos" , :align => :center, :color => "FF0000"	
	end

	def line_items
		move_down 20
		font "Helvetica", :size => 10		
		table line_item_rows, :width => 750, :column_widths => [170, 170, 170, 50, 95, 95], :row_colors => ["8CB9DC" , "F0F0F0"], :header => true  do
			row(0).font_style = :bold
			columns(0...5).align = :left
			#columns(3).align = :right
		end
	end

	def line_item_rows
		#[[I18n.t('pdf.device_id'),I18n.t('pdf.supplier_id'), I18n.t('pdf.contract_no'), I18n.t('pdf.start_date'), I18n.t('pdf.end_date')]] +
		[[ "Nombre de Equipo" , "Proveedor" , "No. de Contrato" , "Monto" , "Fecha inicial" , "Fecha final" ]] +
		@report.map do |rep|
		#@report.line_items.map do |item|
			[rep.contract.device.name, rep.contract.supplier.business_name, rep.contract.contract_no, rep.monto, rep.start_date, rep.end_date]
		end
	end
	#end
end
