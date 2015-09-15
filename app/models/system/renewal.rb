class System::Renewal < ActiveRecord::Base
has_many :Siteviews
belongs_to :contract, :class_name => 'System::Contract', :foreign_key => 'contract_id'
validates :contract_id, :start_date, :end_date, presence: true

  def stat
        if Time.now >= start_date and Time.now <= end_date
          :active
        else
          :finished
        end
  end


end
