class Catalogs::Supplier < ActiveRecord::Base
include Searchable

has_many :Contracts
validates :business_name, uniqueness: true, presence: true
validates :contact, :phone, :phone_office, presence: true
validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, presence: true

def short_name(length=18)
	business_name.truncate(length)
end
end
