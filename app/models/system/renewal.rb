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

  def vigencia
  	if end_date.between?(Time.now,Time.now+30.days)
  		:to_expire
  	elsif end_date > Time.now+31.days
  		:active
  	elsif end_date < Time.now
  		:finished
  	end
  end

  def date_filter(start_date_param,end_date_param)
	puts 'aki entra la funcion XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
	puts start_date_param
	puts end_date_param
	if start_date >= start_date_param and end_date <= end_date_param
		:active
	else
		:inactive
	end
  end

end
