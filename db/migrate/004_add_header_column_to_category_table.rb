class AddHeaderColumnToCategoryTable < ActiveRecord::Migration
  def self.up
    add_column :categories, :parent_category_id, :integer
  end

  def self.down
    remove_column :categories, :parent_category_id
  end
end
