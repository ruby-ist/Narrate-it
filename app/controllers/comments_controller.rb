class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(authenticated_params)
    @comment.name = current_user.username
    @comment.save
    redirect_to @post
  end

  private

  def authenticated_params
    params.require(:comment).permit(:name,:comment)
  end
end
