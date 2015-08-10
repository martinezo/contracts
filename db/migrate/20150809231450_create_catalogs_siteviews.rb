class CreateCatalogsSiteviews < ActiveRecord::Migration
  def change
    create_table :catalogs_siteviews do |t|
      t.integer :contract_id, null: false
      t.datetime :visit_date, null: false
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
