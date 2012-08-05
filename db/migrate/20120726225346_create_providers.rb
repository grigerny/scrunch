class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :bio
      t.string :insured
      t.integer :service_id

      t.timestamps
    end
  end
end
