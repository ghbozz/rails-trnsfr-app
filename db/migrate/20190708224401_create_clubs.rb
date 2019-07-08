class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :nation
      t.string :league

      t.timestamps
    end
  end
end
