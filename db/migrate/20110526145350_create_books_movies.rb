class CreateBooksMovies < ActiveRecord::Migration
  def self.up
    create_table :users
    change_table :users do |t|
      t.string :login, :null => false
      t.index :login, :unique => true
    end
    create_table :books
    change_table :books do |t|
      t.string :title, :null => false
      t.index :title, :unique => true
    end
    create_table :movies
    change_table :movies do |t|
      t.string :title, :null => false
      t.index :title, :unique => true
    end
  end

  def self.down
    drop_table :books
    drop_table :movies
    drop_table :users
  end
end
