require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { Topic.create!( name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!( name: "Test User", email: "test@bloccit.com", password: "password") }
  let(:post) { topic.posts.create!( title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:vote) { Vote.create!(value: 1, post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:value) }

  it { is_expected.to validate_inclusion_of(:value).in_array([-1,1]) } #tests whether value is either -1 or 1

  #TESTS FOR AFTER_SAVE CALLBACK
  describe "update_post callback" do
    it "triggers update_post on save" do
      expect(vote).to receive(:update_post).at_least(:once) #expect update_post_rank to be called on vote after it is saved
      vote.save!
    end

    it "#update_post should call update_rank on post" do
      expect(post).to receive(:update_rank).at_least(:once) #expect the votes' post to receive a call to update_rank
      vote.save!
    end
  end

end
