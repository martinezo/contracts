class CreateSystemSiteviews < ActiveRecord::Migration
 def change
    create_table :system_siteviews do |t|
      t.integer :contract_id, null: false
      t.datetime :visit_date, null: false
      t.boolean :completed

      t.timestamps null: false
    end
	
	add_foreign_key(:system_contracts, :catalogs_suppliers, column: 'supplier_id')
	add_foreign_key(:system_contracts, :catalogs_devices, column: 'device_id')
  	add_foreign_key(:catalogs_devices, :catalogs_locations, column: 'location_id')
	add_foreign_key(:system_siteviews, :system_contracts, column: 'contract_id')
	
  end
end
