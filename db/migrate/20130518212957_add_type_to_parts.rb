class AddTypeToParts < ActiveRecord::Migration
  def up
    add_column :sections, :type, :string
  end

  def down
    # remove_column :parts, :type
  end
end
