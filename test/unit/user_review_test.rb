require File.dirname(__FILE__) + '/../test_helper'

class UserReviewTest < ActiveSupport::TestCase
  def setup
    @user = Factory(:user)
    @book = Factory(:book)
    @movie = Factory(:movie)
  end
  context 'with movie and book reviews' do
    setup do
      UserReview.create!(:user => @user, :book => @book)
      UserReview.create!(:user => @user, :movie => @movie)
    end
    should_change("review count", :by => 2){ UserReview.count }
    should 'prevent saving with activerecord' do
      duplicate_review = UserReview.new(:user => @user, :movie => @movie)
      assert !duplicate_review.save
    end
    should 'prevent saving with SQL' do
      assert_raise ActiveRecord::RecordNotUnique do
        UserReview.connection.execute <<-EOSQL
        INSERT INTO user_reviews (user_id, book_id)
          VALUES (#{@user.id}, #{@book.id})
        EOSQL
      end
    end
  end
end
