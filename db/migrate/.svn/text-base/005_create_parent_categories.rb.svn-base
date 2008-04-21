class CreateParentCategories < ActiveRecord::Migration
  def self.up
    create_table :parent_categories do |t|
      t.column :name, :string
      t.column :slug, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :parent_categories
  end
end
