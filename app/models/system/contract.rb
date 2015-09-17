class System::Contract < ActiveRecord::Base
belongs_to :device, :class_name => 'Catalogs::Device', :foreign_key => 'device_id'
belongs_to :supplier, :class_name => 'Catalogs::Supplier', :foreign_key => 'supplier_id'
has_many :Renewals
validates :device_id, :supplier_id, :contract_no, :description ,presence: true

end
