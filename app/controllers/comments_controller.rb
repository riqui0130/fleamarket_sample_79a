class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to item_path(comment.item.id),
      notice: "コメントを投稿しました"
    else
      redirect_to item_path(comment.item.id),
      alert: "コメントを入力してください"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end