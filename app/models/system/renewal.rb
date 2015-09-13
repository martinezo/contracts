class System::Renewal < ActiveRecord::Base
has_many :Siteviews
belongs_to :contract, :class_name => 'System::Contract', :foreign_key => 'contract_id'
validates :contract_id, :start_date, :end_date, presence: true
end
