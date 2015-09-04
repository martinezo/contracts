class System::Siteview < ActiveRecord::Base
belongs_to :renewal, :class_name => 'System::Renewal', :foreign_key => 'renewal_id'
validates :renewal_id, :visit_date, presence: true
end
