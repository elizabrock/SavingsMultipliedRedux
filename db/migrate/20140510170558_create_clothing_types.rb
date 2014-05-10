class CreateClothingTypes < ActiveRecord::Migration
  def change
    create_table :clothing_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
