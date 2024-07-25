class PostsController < ApplicationController
  before_action :check_logon, except: %w[show]
  before_action :set_forum, only: %w[create new]
  before_action :set_post, only: %w[show edit update destroy]
  # access control!! a user can only edit or update or delete their own posts
  before_action :check_access, only: %w[edit update delete]

  def create
    # we create a new post for the current forum
    @post = @forum.posts.new(post_params)
    @post.save
    redirect_to @post, notice: "Your post was created."
  end

  def new
    @post = @forum.posts.new 
  end

  def edit
  end

  def show
  end

  def update
    @post = Post.new(post_params)
    @post.save
    redirect_to @post, notice: "Your post was updated."
  end

  def destroy
    # we need to save this, so we can redirect to the forum after the destroy
    @forum = @post.forum
    @post.destroy
    redirect_to @forum, notice: "Your post was deleted."
  end

private

  def check_logon 
    if !@current_user
      redirect_to forums_path, notice: "You can't add, modify, or delete posts before logon."
    end
  end

  def set_forum
    # If you check the routes for posts, you see that this is the forum parameter
    @forum = Forum.find(params[:forum_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_access
    if @post.user_id != session[:current_user][:id]
      redirect_to forums_path, notice: "That's not your post, so you can't change it."
    end
  end

  # security check, also known as "strong parameters"
  def post_params  
    # here we have to add a parameter so that the post is associated with the current user
    params[:post][:user_id] = session[:current_user]["id"]
    params.require(:post).permit(:title,:content,:user_id)
  end
end
