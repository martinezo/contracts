class System::Contract < ActiveRecord::Base
belongs_to :Device
belongs_to :Supplier
has_many :Siteviews
validates :device_id, :supplier_id, :start_date, :end_date, :contract_no ,presence: true
end