class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :linked_in_id
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :headline
    remove_column :users, :location
  end

  def down
    add_column :users, :linked_in_id
    add_column :users, :first_name
    add_column :users, :last_name
    add_column :users, :headline
    add_column :users, :location
  end
end
