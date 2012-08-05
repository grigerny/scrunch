class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title

      t.timestamps
    end
  end
end
