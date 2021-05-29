class PostCommentsController < ApplicationController

  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_image_id = post_image.id
    if comment.save
      redirect_to post_image_path(post_image), success: 'コメントしました'
    else
      flash.now[:danger] = 'コメントできませんでした'
      render 'post_images/show'
    end
  end

  def destroy
    if PostComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
      redirect_to post_image_path(params[:post_image_id]), success: 'コメントを削除しました'
    else
      flash.now[:danger] = 'コメント削除てきませんでした'
      render 'post_images/show'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
