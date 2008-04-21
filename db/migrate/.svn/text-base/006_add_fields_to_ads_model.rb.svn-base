class AddFieldsToAdsModel < ActiveRecord::Migration
  def self.up
      add_column :ads, :active, :boolean, :default => false
      add_column :ads, :activation_hash, :string
  end

  def self.down
      remove_column :ads, :active
      remove_column :ads, :activation_hash
  end
  
end
