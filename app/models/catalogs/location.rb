class Catalogs::Location < ActiveRecord::Base
has_many :Devices
validates :department, :responsible, :email, presence: true
end