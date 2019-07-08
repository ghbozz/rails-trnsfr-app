class AddImageToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :image, :string
  end
end
