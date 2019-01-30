require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) } #create a parent topic for the post since posts are nested under topics
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }


  # POSTS_CONTROLLER#SHOW ACTION TESTS
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to have_http_status(:success) #confirms get #show routes successfully for the post with id passed through params hash
    end

    it 'renders the #show view' do
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to render_template(:show) #confirm that the show view is rendered for the post requested
    end

    it 'assigns my_post to @post' do
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      expect(assigns(:post)).to eq(my_post) #confirm that the post showed is the post that was requested
    end
  end


  # POSTS_CONTROLLER#NEW ACTION TESTS
  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success) #confirms get #new routes successfully
    end

    it 'renders the #new view' do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template(:new) #confirms the PostsController#new view renders successfully
    end

    it 'instantiates @post' do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:post)).not_to be_nil #confirms that a new instance of @post is initialized
    end
  end


  # POSTS_CONTROLLER#CREATE ACTION TESTS
  describe 'POST #create' do
    it 'increases the number of Post by 1' do
      expect { post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post, :count).by(1) #confirms the POST action successfully increases the Post object count by 1(new row in the Posts table) using the PostConrtoller#create action
    end

    it 'assigns the new post to @post' do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq(Post.last) #confirms the new Post object is assigned to @post
    end

    it 'redirects to the new post' do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to([my_topic, Post.last]) #confirms our view is redirected to the newly created post
    end
  end


  # POSTS_CONTROLLER#EDIT ACTION TESTS
  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns post to be updated to @post' do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      post_instance = assigns(:post)
      expect(post_instance.id).to eq(my_post.id)
      expect(post_instance.title).to eq(my_post.title)
      expect(post_instance.body).to eq(my_post.body)
    end
  end


  # POSTS_CONTROLLER#EDIT ACTION TESTS
  describe 'PUT #update' do
    it 'updates post with the expected attributes' do
      new_title = RandomData.random_sentence #create new title for updated_post
      new_body = RandomData.random_paragraph #create new body for updated_post

      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body} } #update the content of my_post using #update controller action
      updated_post = assigns(:post) #assigns @post to updated_post

      expect(updated_post.id).to eq(my_post.id)
      expect(updated_post.title).to eq(new_title)
      expect(updated_post.body).to eq(new_body)
    end

    it 'redirects to the updated post' do
      new_title = RandomData.random_sentence #create new title for updated_post
      new_body = RandomData.random_paragraph #create new body for updated_post
      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body} } #update the content of my_post using #update controller action
      expect(response).to redirect_to([my_topic, my_post])
    end
  end


  # POSTS_CONTROLLER#DESTROY ACTION TESTS
  describe 'DELETE #destroy' do
    it 'deletes the post' do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      count = Post.where({id: my_post.id}).size #assign the size of the array containing my_post to count
      expect(count).to eq(0)
    end

    it 'redirects to the topics show' do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to redirect_to(my_topic)
    end
  end

end
