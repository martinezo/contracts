class CreateSystemSiteviews < ActiveRecord::Migration
 def change
    create_table :system_siteviews do |t|
      t.integer :renewal_id, null: false
      t.datetime :visit_date, null: false
      t.boolean :completed

      t.timestamps null: false
    end	
  end
end
