class Catalogs::Device < ActiveRecord::Base
has_many :Contracts
belongs_to :location, :class_name => 'Catalogs::Location', :foreign_key => 'location_id'
validates :name, :unam_stock_number, :location_id, presence: true
end
