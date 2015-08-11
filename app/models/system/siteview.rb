class System::Siteview < ActiveRecord::Base
belongs_to :Contract
validates :contract_id, :visit_date, presence: true
end
