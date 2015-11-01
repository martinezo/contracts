class System::Contract < ActiveRecord::Base
belongs_to :device, :class_name => 'Catalogs::Device', :foreign_key => 'device_id'
belongs_to :supplier, :class_name => 'Catalogs::Supplier', :foreign_key => 'supplier_id'
has_many :Renewals
validates :device_id, :supplier_id, :description ,presence: true
validates :contract_no, uniqueness: true
before_create :validate
 
attr_accessor :start_date
attr_accessor :end_date
attr_accessor :monto

def short_name(length=18)
	contract_no.truncate(length)
end

def validate
     start_date.to_date
end

end
