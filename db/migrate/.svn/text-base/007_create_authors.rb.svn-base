class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
