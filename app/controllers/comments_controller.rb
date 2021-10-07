class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(authenticated_params)
    @comment.user_id = current_user.id
    @comment.name = current_user.username
    flash[:error] = "Comment Box is Empty!!!" unless @comment.save
    redirect_to post_path(@post, anchor: 'comment')
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path params[:post_id]
  end

  private

  def authenticated_params
    params.require(:comment).permit(:name,:comment)
  end
end
