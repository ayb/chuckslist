class AddAuthorIpAndAuthorBanFlag < ActiveRecord::Migration
  def self.up
    # record IP address of poster with ad
    add_column :ads, :author_ip, :string
    # record IP address of author when they first submit email address
    add_column :authors, :ip, :string
    # add ban flag to authors table
    add_column :authors, :banned, :boolean
    # add ban flag to users table
    add_column :users, :banned, :boolean
  end

  def self.down
    remove_column :ads, :author_ip
    remove_column :authors, :ip
    remove_column :authors, :banned
    remove_column :users, :banned
  end
end
