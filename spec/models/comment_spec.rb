require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Test", email: "test@bloccit.com", password: "password") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:comment) { Comment.create!(body: "New comment body.", post: post) }

  describe 'attributes' do
    it 'has a body attribute' do
      expect(comment).to have_attributes(body: "New comment body.")
    end
  end

end
