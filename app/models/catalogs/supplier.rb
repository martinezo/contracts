class Catalogs::Supplier < ActiveRecord::Base
has_many :Contracts
validates :business_name, :contact, :phone, :email, presence: true
end