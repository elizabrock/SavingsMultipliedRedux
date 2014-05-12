class CreateAuctionClothingSizes < ActiveRecord::Migration
  def change
    create_table :auction_clothing_sizes do |t|
      t.integer :auction_id
      t.integer :clothing_size_id

      t.timestamps
    end
  end
end
