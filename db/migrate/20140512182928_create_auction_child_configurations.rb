class CreateAuctionChildConfigurations < ActiveRecord::Migration
  def change
    create_table :auction_child_configurations do |t|
      t.integer :auction_id
      t.integer :child_configuration_id

      t.timestamps
    end
  end
end
