class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :specialty
      t.boolean :leader, default: false
      t.string :password_digest
      t.string :uid
      t.string :email
      t.timestamps
    end
  end
end
