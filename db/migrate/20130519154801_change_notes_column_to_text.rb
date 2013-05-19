class ChangeNotesColumnToText < ActiveRecord::Migration
  def up
    remove_column :parts, :notes
    add_column :parts, :notes, :text
  end

  def down
    remove_column :parts, :notes
    add_column :parts, :notes, :string
  end
end
