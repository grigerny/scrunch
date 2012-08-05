class RenameColumn < ActiveRecord::Migration
  def up
    rename_column :providers, :address, :street
  end

  def down
  end
end
