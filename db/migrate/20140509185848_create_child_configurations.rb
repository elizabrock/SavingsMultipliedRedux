class CreateChildConfigurations < ActiveRecord::Migration
  def change
    create_table :child_configurations do |t|
      t.string :siblings_type
      t.string :genders

      t.timestamps
    end
  end
end
