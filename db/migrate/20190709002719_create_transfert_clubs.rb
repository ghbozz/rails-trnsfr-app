class CreateTransfertClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :transfert_clubs do |t|
      t.references :transfert, foreign_key: true
      t.references :club, foreign_key: true

      t.timestamps
    end
  end
end
