class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.text :details

      t.references :section

      t.timestamps
    end
  end
end
