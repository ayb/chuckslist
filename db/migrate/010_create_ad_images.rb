class CreateAdImages < ActiveRecord::Migration
  def self.up
    create_table :ad_images do |t|
      
      t.integer :ad_id


      # attachment_fu columns
      t.integer  :parent_id
      t.string   :content_type
      t.string   :filename
      t.string   :thumbnail
      t.integer  :size
      t.integer  :width
      t.integer  :height
      t.datetime :created_at
      t.datetime :updated_at


      t.timestamps
    end
  end

  def self.down
    drop_table :ad_images
  end
end
