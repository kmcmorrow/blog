class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    comment = @article.comments.create(comment_params)
    if comment.invalid?
      flash[:error] ||= []
      flash[:error] << "Name can't be blank" if comment.name.blank?
      flash[:error] << "Comment can't be blank" if comment.text.blank?
    end
    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :text)
  end
end
