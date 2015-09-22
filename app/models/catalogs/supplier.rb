class Catalogs::Supplier < ActiveRecord::Base
include Searchable

has_many :Contracts
validates :business_name, :contact, :phone, :email, presence: true

def short_name(length=18)
	business_name.truncate(length)
end
end
