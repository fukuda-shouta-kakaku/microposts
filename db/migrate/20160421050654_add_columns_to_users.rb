class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :nickname   , :string
    add_column :users, :place      , :string
    add_column :users, :description, :string
  end

  def down
    remove_column :users, :nickname   , :string
    remove_column :users, :place      , :string
    remove_column :users, :description, :string
  end
end
