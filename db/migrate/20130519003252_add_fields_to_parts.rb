class AddFieldsToParts < ActiveRecord::Migration
  def up
    add_column :parts, :location, :string
    add_column :parts, :start_date, :string
    add_column :parts, :end_date, :string
    add_column :parts, :notes, :string
  end

  def down
    remove_column :parts, :location
    remove_column :parts, :start_date
    remove_column :parts, :end_date
    remove_column :parts, :notes
  end
end
