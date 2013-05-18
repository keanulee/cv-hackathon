class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :linked_in_id
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :headline
    remove_column :users, :location
  end

  def down
    add_column :users, :linked_in_id, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :headline, :string
    add_column :users, :location, :string
  end
end
