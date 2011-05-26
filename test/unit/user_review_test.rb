require File.dirname(__FILE__) + '/../test_helper'

class UserReviewTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(:login => 'bob')
    @book = Book.create!(:title => 'Snow Crash')
    @movie = Movie.create!(:title => 'Jaws')
  end
  def test_user_review_activerecord_check
    
    book_review = UserReview.new(:user => @user, :book => @book)
    assert book_review.save

    movie_review = UserReview.new(:user => @user, :movie => @movie)
    assert movie_review.save

    duplicate_review = UserReview.new(:user => @user, :movie => @movie)
    assert !duplicate_review.save # No, cannot save that
  end

  def test_user_review_database_check
    book_review = UserReview.create(:user => @user, :book => @book)
    assert book_review.save

    movie_review = UserReview.create(:user => @user, :movie => @movie)
    assert movie_review.save

    assert_raise ActiveRecord::RecordNotUnique do
      UserReview.connection.execute <<-EOSQL
      INSERT INTO user_reviews (user_id, book_id)
        VALUES (#{@user.id}, #{@book.id})
      EOSQL
    end
  end
end
