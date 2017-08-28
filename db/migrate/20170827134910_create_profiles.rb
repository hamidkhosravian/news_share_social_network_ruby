class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.date :birthday
      t.text :summery
      t.integer :gender
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
