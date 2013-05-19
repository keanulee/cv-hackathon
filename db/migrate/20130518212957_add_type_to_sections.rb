class AddTypeToSections < ActiveRecord::Migration
  def up
    add_column :sections, :type, :string
  end

  def down
    remove_column :sections, :type
  end
end
