class CreateClothingConditions < ActiveRecord::Migration
  def change
    create_table :clothing_conditions do |t|
      t.string :name

      t.timestamps
    end
  end
end
