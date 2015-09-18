class ReportPDF < Prawn::Document
	def initialize(report)
		super()
		@report = report
		report_number
		line_items
	end

	def report_number
		text "Report \# #{@report.id}", size: 30, :styles => [:bold]
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
		[["Device ID","Supplier ID", "Contract No", "Start Date", "End Date"], #] +
		#@report.line_items.map do |item|
			[@report.device_id, @report.supplier_id, @report.contract_no, @report.created_at.to_s, @report.updated_at.to_s]]
		#end
	end
end
