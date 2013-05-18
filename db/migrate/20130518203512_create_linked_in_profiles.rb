class CreateLinkedInProfiles < ActiveRecord::Migration
  def change
    create_table :linked_in_profiles do |t|

      t.timestamps
    end
  end
end
