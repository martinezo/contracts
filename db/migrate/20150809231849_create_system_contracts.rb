class CreateSystemContracts < ActiveRecord::Migration
  def change
    create_table :system_contracts do |t|
      t.integer :device_id, null: false
      t.integer :supplier_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :contract_no, null: false

      t.timestamps null: false
    end
  end
end
