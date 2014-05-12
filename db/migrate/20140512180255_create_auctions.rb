class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer  :user_id
      t.string   :title
      t.text     :description
      t.integer  :starting_price,        :default => 0
      t.integer  :brand_id
      t.integer  :clothing_condition_id
      t.integer  :clothing_type_id
      t.integer  :season_id
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :item_photo
      t.timestamps
    end
  end
end
