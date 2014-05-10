class CreateClothingSizes < ActiveRecord::Migration
  def change
    create_table :clothing_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
