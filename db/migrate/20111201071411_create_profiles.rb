class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :gender
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.references :user

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
