class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :linked_in_id
      t.string :first_name
      t.string :last_name
      t.string :headline
      t.string :location

      t.timestamps
    end
  end
end
