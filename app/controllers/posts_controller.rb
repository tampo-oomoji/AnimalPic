class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_post_tags(tag_list)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.post_tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')

    if params[:post][:animalpics_ids]
      params[:post][:animalpics_ids].each do |animalpics_id|
        animalpic = @post.animalpics.find(animalpics_id)
        animalpic.purge
    end

    end
    if @post.update(post_params)
      @post.save_post_tags(tag_list)
      redirect_to post_path(@post)

    else
      render :edit
    end



    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html{ redirect_to @post, notice: "Post was successfully update." }
    #     format.json{ render :show, status: :ok, location: @post }
    #   else
    #       format.html { render :edit, status: :unprocessable_entity }
    #     format.json{ render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  def search_tag
    @tag_list = PostTag.all
    @tag = PostTag.find(params[:post_tag_id])
    @posts = @tag.posts
  end

  def index
    sample_ids = Post.all.ids.sample(10)
    @random = Post.where(id: sample_ids)
    @posts = Post.all
    @tag_list = PostTag.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments

    @comment = Comment.new
    @tag_list = @post.post_tags.pluck(:name).join(',')
    @post_tags = @post.post_tags

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, animalpics: [], )
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path unless @post
  end
end
