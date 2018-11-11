class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :type_player
      t.string :role
      t.string :quote
    
      t.timestamps
    end
  end
end
