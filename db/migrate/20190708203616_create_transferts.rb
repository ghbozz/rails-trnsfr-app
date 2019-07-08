class CreateTransferts < ActiveRecord::Migration[5.2]
  def change
    create_table :transferts do |t|
      t.string :player_name
      t.integer :player_age
      t.string :player_nation
      t.string :from
      t.string :to
      t.string :value
      t.string :image

      t.timestamps
    end
  end
end
