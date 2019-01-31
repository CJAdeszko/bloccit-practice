class User < ApplicationRecord
  before_save { self.email = email.downcase if email.present? }
  before_save :format_name

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, length: { minimum: 6 }, presence: true, if: 'password_digest.nil?' #executes when creating a new user to ensure a password is entered
  validates :password, length: { minimum: 6 }, allow_blank: true #allows password to be blank when updating other attributes of the user
  validates :email, length: { minimum: 3, maximum: 254 }, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  private
  def format_name
    self.name = name.split.map(&:capitalize).join(' ') if name
  end
end
