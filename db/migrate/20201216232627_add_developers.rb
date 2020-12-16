class AddDevelopers < ActiveRecord::Migration[6.0]
  def change
    create_table :developers do |t|
      t.integer :team_id
      t.string :name
      t.string :phone_number

      t.timestamps
    end

    add_index :developers, :team_id
  end
end
