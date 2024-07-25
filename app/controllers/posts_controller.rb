class PostsController < ApplicationController
  before_action :check_logon, except: %w[show]
  before_action :set_forum, only: %w[create new]
  before_action :set_post, only: %w[show edit update destroy]
  # access control!! a user can only edit or update or delete their own posts
  before_action :check_access, only: %w[edit update destroy]

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
    if @post.update(post_params)
      redirect_to @post, notice: "Your post was updated."
    else
      render :edit
    end
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
    if session[:current_user].is_a?(Hash)
      current_user_id = session[:current_user]["id"]
    else
      current_user_id = session[:current_user]
    end

    if @post.user_id != current_user_id
      redirect_to forums_path, notice: "That's not your post, so you can't change it."
    end
  end

  # security check, also known as "strong parameters"
  def post_params  
    if session[:current_user].is_a?(Hash)
      user_id = session[:current_user]["id"]
    else
      user_id = session[:current_user]
    end

    params[:post][:user_id] = user_id
    params.require(:post).permit(:title, :content, :user_id)
  end
end
