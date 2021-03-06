class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, length: { minimum: 6 }, presence: true, if: 'password_digest.nil?' #executes when creating a new user to ensure a password is entered
  validates :password, length: { minimum: 6 }, allow_blank: true #allows password to be blank when updating other attributes of the user
  validates :email, length: { minimum: 3, maximum: 254 }, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first #calling first on the array of favorites where post_id = post.id returns either the favorite or nil
  end
end
