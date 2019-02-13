require 'rails_helper'

RSpec.describe Post, type: :model do
  #Create parent topic for post testing
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:topic) { Topic.create!(name: name, description: description) }

  #Create post for testing
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:user)  { User.create!(name: "Test", email: "test@bloccit.com", password: "password" ) }
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  #Confirm relationship with Comments
  it { is_expected.to have_many(:comments) }

  #Confirm relationship with Votes
  it {is_expected.to have_many(:votes) }

  #Confirm relationship to Topic
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  #Validate presence of attributes
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  #Validate length of attributes
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }


  describe 'attributes' do
    it 'has title, body, and user attributes' do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end

  describe "voting" do
    before do
      3.times { post.votes.create!(value: 1, user: user) }
      2.times { post.votes.create!(value: -1, user: user) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect(post.up_votes).to eq(@up_votes)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect(post.down_votes).to eq(@down_votes)
      end
    end

    describe "#points" do
      it "returns the sum of all up and down votes" do
        expect(post.points).to eq(@up_votes - @down_votes)
      end
    end

    describe "#update_rank do" do
      #Determine the age of the post by subtracting a standard time from its  created_at time.
      #A standard time in this context is known as an epoch.
      #This makes newer posts start with a higher ranking, which decays over time;
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end

      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1, user: user)
        expect(post.rank).to eq(old_rank + 1)
      end

      it "updates the rank when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1, user: user)
        expect(post.rank).to eq(old_rank - 1)
      end
    end
  end

  describe "#create_vote" do
    it "automatically #up_votes a post that a user creates" do
      expect(post.up_votes).to eq(1)
    end

    it "calls #create_vote when a post is created" do
      post = topic.posts.new(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
      expect(post).to receive(:create_vote)
      post.save
    end

    it "associates the up_vote with the user" do
      expect(post.votes.first.user).to eq(post.user)
    end
  end

end
