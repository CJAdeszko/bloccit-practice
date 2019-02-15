class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  after_create :create_favorite

  default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count #fetch collection of votes with value: 1 - "votes" implied self.vote
  end

  def down_votes
    votes.where(value: -1).count #fetch collection of votes with value: -1
  end

  def points
    votes.sum(:value) #use ActiveRecord #sum method to add the value of all a given posts votes
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds #divide the number of seconds difference between post creation and epoch (1/1/1970) by the number of seconds in a day = age in days
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  def create_favorite
    Favorite.create(post: self, user: self.user)
    FavoriteMailer.new_post(self).deliver_now
  end
end
