require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:topic) { Topic.create!(title: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user)  { User.create!(name: "Test User", email: "test@bloccit.com", password: "password") }
  let(:post)  { topic.posts.create!(name: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:favorite)  { Favorite.create!(post: post, user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }

end
