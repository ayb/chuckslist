class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.column :title, :string
      t.column :ad, :text
      t.column :expiration, :datetime  # defaults to 30 days after posting
      t.column :email, :string # response e-mail so each ad has its own 
      t.column :author_id, :integer
      t.column :category_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
