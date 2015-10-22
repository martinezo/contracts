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
		text "Reporte general de Contratos", :align => :center, :color => "FF0000"
	end

	def line_items
		move_down 20
		font "Helvetica", :size => 10		
		table line_item_rows, :row_colors => ["8CB9DC" , "F0F0F0"], :header => true  do
			row(0).font_style = :bold
			columns(0...1).align = :right
		end
	end

	def line_item_rows
		[["Device ID","Supplier ID", "Contract No", "Fecha inicio", "Fecha fin"]] +
		@report.map do |rep|
		#@report.line_items.map do |item|
			[rep.device.name, rep.supplier.business_name, rep.contract_no, "00-0000000-0000", "00-0000000-0000"]
		end
	end
	#end
end
