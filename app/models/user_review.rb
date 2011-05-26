class UserReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  belongs_to :book
  validates_presence_of :user
  validates_associated :user
  validates_associated :book
  validates_associated :movie
  validate do |u|
    u.errors.add :base, "Must belong to book or movie" if(u.book.nil? && u.movie.nil?)
  end
  validates_uniqueness_of :user_id, :scope => [:book_id, :movie_id]
end
