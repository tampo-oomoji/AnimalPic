class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if params[:post][:animalpics_ids]
      params[:post][:animalpics_ids].each do |animalpics_id|
        animalpic = @post.animalpics.find(animalpics_id)
        animalpic.purge
    end

    end

    respond_to do |format|
      if @post.update(post_params)
        format.html{ redirect_to @post, notice: "Post was successfully update." }
        format.json{ render :show, status: :ok, location: @post }
      else
          format.html { render :edit, status: :unprocessable_entity }
        format.json{ render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end






  def index
    @random = Post.order("RANDOM()").limit(3)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, animalpics: [])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path unless @post
  end
end
