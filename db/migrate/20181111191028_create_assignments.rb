class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :description
      t.integer :team_id
      t.integer :player_id

      t.timestamps
    end
  end
end
