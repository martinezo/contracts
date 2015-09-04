class System::Contract < ActiveRecord::Base
belongs_to :device, :class_name => 'Catalogs::Device', :foreign_key => 'device_id'
belongs_to :supplier, :class_name => 'Catalogs::Supplier', :foreign_key => 'supplier_id'
has_many :Renewals
validates :device_id, :supplier_id, :start_date, :end_date, :contract_no ,presence: true

  def stat
	if Time.now >= start_date and Time.now <= end_date
	  :active
	else
	  :finished
	end
  end

end
