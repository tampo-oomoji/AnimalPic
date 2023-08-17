class CommentsController < ApplicationController
  def create
   post = Post.find(params[:post_id])
   comment = current_user.comments.new(comment_params)
   comment.post_id = post.id
   if comment.save
   redirect_to post_path(post.id)
   else
   redirect_to post_path(post.id)
   end

  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end

end