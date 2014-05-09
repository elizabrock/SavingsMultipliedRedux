class CreateRelationshipToChildren < ActiveRecord::Migration
  def change
    create_table :relationship_to_children do |t|
      t.string :name

      t.timestamps
    end
  end
end
