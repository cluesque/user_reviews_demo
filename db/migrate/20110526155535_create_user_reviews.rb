class CreateUserReviews < ActiveRecord::Migration
  def self.up
    create_table :user_reviews
    change_table :user_reviews do |t|
      t.references :user, :null => false
      t.foreign_key :users
      t.references :movie
      t.foreign_key :movies
      t.references :book
      t.foreign_key :books
    end
    # ActiveRecord handy unique constraint syntax sugar:
    add_index :user_reviews, [:user_id, :book_id, :movie_id], :unique => true
  end

  def self.down
    drop_table :user_reviews
  end
end
