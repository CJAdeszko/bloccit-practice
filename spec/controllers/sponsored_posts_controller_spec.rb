require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:sponsored_test) { topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: Random.new.rand(1..500)) }


  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: topic.id, id: sponsored_test.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, params: { topic_id: topic.id, id: sponsored_test.id }
      expect(response).to render_template(:show)
    end

    it 'assigns sponsored_test to @sponsored_post' do
      get :show, params: { topic_id: topic.id, id: sponsored_test.id }
      expect(assigns(:sponsored_post)).to eq(sponsored_test)
    end
  end


  describe "GET #new" do
    it "returns http success" do
      get :new, params: { topic_id: topic.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new, params: { topic_id: topic.id }
      expect(response).to render_template(:new)
    end

    it 'instantiates @sponsored_post' do
      get :new, params: { topic_id: topic.id }
      expect(assigns(:sponsored_post)).to_not be_nil
    end
  end


  describe 'POST #create' do
    it 'increases the number of sponsored posts by 1' do
      expect { post :create, params: { topic_id: topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: Random.new.rand(1..500) } } }.to change(SponsoredPost, :count).by(1)
    end

    it 'assigns the new sponsored post to @sponsored_post' do
      post :create, params: { topic_id: topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: Random.new.rand(1..500) } }
      expect(assigns(:sponsored_post)).to eq(SponsoredPost.last)
    end

    it 'redirects to the new sponsored post' do
      post :create, params: { topic_id: topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: Random.new.rand(1..500) } }
      expect(response).to redirect_to([topic, SponsoredPost.last])
    end
  end


  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { topic_id: topic.id, id: sponsored_test.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      get :edit, params: { topic_id: topic.id, id: sponsored_test.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the sponsored post to be updated to @sponsored_post' do
      get :edit, params: { topic_id: topic.id, id: sponsored_test.id }
      sponsored_instance = assigns(:sponsored_post)
      expect(sponsored_instance.id).to eq(sponsored_test.id)
      expect(sponsored_instance.title).to eq(sponsored_test.title)
      expect(sponsored_instance.body).to eq(sponsored_test.body)
      expect(sponsored_instance.price).to eq(sponsored_test.price)
    end
  end


  describe 'PUT #update' do
    it 'updates the sponsored post with the expected attributes' do
      new_tite = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = Random.new.rand(1..500)

      put :update, params: { topic_id: topic.id, id: sponsored_test.id, sponsored_post: {title: new_tite, body: new_body, price: new_price } }
      updated_test_post = assigns(:sponsored_post)

      expect(updated_test_post.id).to eq(sponsored_test.id)
      expect(updated_test_post.title).to eq(new_tite)
      expect(updated_test_post.body).to eq(new_body)
      expect(updated_test_post.price).to eq(new_price)
    end

    it 'redirects to the updated sponsored post' do
      new_tite = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = Random.new.rand(1..500)

      put :update, params: { topic_id: topic.id, id: sponsored_test.id, sponsored_post: {title: new_tite, body: new_body, price: new_price } }

      expect(response).to redirect_to([topic, sponsored_test])
    end
  end


    describe 'DELETE #destroy' do
      it 'deletes the sponsored post' do
        delete :destroy, params: { topic_id: topic.id, id: sponsored_test.id }
        count = SponsoredPost.where({id: sponsored_test.id}).size
        expect(count).to eq(0)
      end

      it 'redirects to the topics #show view' do
        delete :destroy, params: { topic_id: topic.id, id: sponsored_test.id }
        expect(response).to redirect_to(topic)
      end
    end

end
