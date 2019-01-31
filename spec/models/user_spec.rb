require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'Test User', email: 'user@test.com', password: 'Password') }

  #Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  #Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value('user@test.com').for(:email) }

  #Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }


  describe 'attributes' do
    it 'has name and email attributes' do
      expect(user).to have_attributes(name: 'Test User', email: 'user@test.com')
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_name) { User.new(name: '' , email: 'user@test.com') }
    let(:user_with_invalid_email) { User.new(name: 'Test', email: '') }

    it 'should be an invalid user due to blank name' do
      expect(user_with_invalid_name).to_not be_valid
    end

    it 'should be an invalid user due to blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe 'format_name' do
    let(:new_user) { User.new(name: 'test user', email: 'user@test.com', password: 'password') }

    it 'should capitalize the first letter of the user first and last name' do
      new_user.save
      expect(new_user.name).to eq('Test User')
    end
  end

end
