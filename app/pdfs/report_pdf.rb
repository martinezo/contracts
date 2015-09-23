class ReportPDF < Prawn::Document
	def initialize(report)
		super()
		@report = report
		report_number
		line_items
	end

	def report_number
		text "Report \# #{@report.first.contract.contract_no}", size: 30, :styles => [:bold]
	end

	def line_items
		move_down 20
		text "Here goes a table:"
		table line_item_rows do
			row(0).font_style = :bold
			columns(0...1).align = :right
		end
	end

	def line_item_rows
		[["Device ID","Supplier ID", "Contract No", "Start Date", "End Date"]] +
		@report.map do |rep|
		#@report.line_items.map do |item|
			[rep.contract.device.name, rep.contract.supplier.business_name, rep.contract.contract_no, rep.start_date.to_s, rep.end_date.to_s]
		end
	end
	#end
end
