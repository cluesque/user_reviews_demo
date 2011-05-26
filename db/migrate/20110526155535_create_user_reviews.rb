class CreateUserReviews < ActiveRecord::Migration
  def self.up
    create_table :user_reviews
    change_table :user_reviews do |t|
      t.references :user, :null => false
      t.references :movie
      t.references :book
    end
    # ActiveRecord handy unique constraint syntax sugar:
    add_index :user_reviews, [:user_id, :book_id, :movie_id], :unique => true
    # For bonus points, use the foreigner gem to pretty these up:
    execute "ALTER TABLE user_reviews ADD CONSTRAINT user_reviews_user_id_fk
             FOREIGN KEY (user_id) REFERENCES books(id)"
    execute "ALTER TABLE user_reviews ADD CONSTRAINT user_reviews_book_id_fk
             FOREIGN KEY (book_id) REFERENCES books(id)"
    execute "ALTER TABLE user_reviews ADD CONSTRAINT user_reviews_movie_id_fk
             FOREIGN KEY (movie_id) REFERENCES movies(id)"
  end

  def self.down
    drop_table :user_reviews
  end
end
