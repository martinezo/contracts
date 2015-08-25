class System::Siteview < ActiveRecord::Base
belongs_to :contract, :class_name => 'System::Contract', :foreign_key => 'contract_id'
validates :contract_id, :visit_date, presence: true
end
