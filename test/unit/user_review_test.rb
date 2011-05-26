require File.dirname(__FILE__) + '/../test_helper'

class UserReviewTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(:login => 'bob')
    @book = Book.create!(:title => 'Snow Crash')
    @movie = Movie.create!(:title => 'Jaws')
  end
  def test_user_review_activerecord_check
    
    book_review = UserReview.create(:user => @user, :book => @book)
    assert book_review.save

    movie_review = UserReview.create(:user => @user, :movie => @movie)
    assert movie_review.save
    
    duplicate_review = UserReview.create(:user => @user, :movie => @movie)
    assert !duplicate_review.save # No, cannot save that
  end
end
