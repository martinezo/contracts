class Catalogs::Device < ActiveRecord::Base
has_many :Contracts
belongs_to :Location
validates :name, :unam_stock_number, :location_id, presence: true
end