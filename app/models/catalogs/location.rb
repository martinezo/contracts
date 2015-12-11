class Catalogs::Location < ActiveRecord::Base
has_many :Devices
validates :department, :responsible, presence: true
validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, presence: true

  def short_name(length=18)
	department.truncate(length)
  end
end