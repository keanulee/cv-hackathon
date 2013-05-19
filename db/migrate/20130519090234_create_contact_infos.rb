class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :details

      t.references :user

      t.timestamps
    end
  end
end
