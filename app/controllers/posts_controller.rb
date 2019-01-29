class PostsController < ApplicationController
  def index
    @posts = Post.all #populates the entire collection of Post objects for the index action
  end


  def show
    @post = Post.find(params[:id]) #populates an individual Post object using the :id passed through the params hash
  end


  def new
    @post = Post.new
  end


  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post saved successfully"
      redirect_to @post
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
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating the post. Please try again."
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post. Please try again."
      render :show
    end
  end
end
