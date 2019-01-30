class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id]) #populates an individual Post object using the :id passed through the params hash
  end


  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end


  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic

    if @post.save
      flash[:notice] = "Post saved successfully"
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post updated successfully"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error updating the post. Please try again."
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post. Please try again."
      render :show
    end
  end
end
