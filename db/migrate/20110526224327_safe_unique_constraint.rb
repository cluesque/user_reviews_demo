class SafeUniqueConstraint < ActiveRecord::Migration
  def self.up
    remove_index :user_reviews, [:user_id, :book_id, :movie_id]
    execute "CREATE UNIQUE INDEX user_reviews_unique ON user_reviews (user_id, COALESCE(movie_id, 0), COALESCE(book_id, 0))"
  end

  def self.down
    execute "DROP INDEX user_reviews_unique"
    add_index :user_reviews, [:user_id, :book_id, :movie_id], :unique => true
  end
end
