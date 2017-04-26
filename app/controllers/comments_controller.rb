class CommentsController < ApplicationController

  before_action :set_comment_blog, only: [:show, :edit, :update, :destroy]

  #action for save and post comments
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました'}
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel",'comment_created',{
            message: 'あなたの作成したブログにコメントが付きました'
            })
        end
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @blog = @comment.blog
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました'}
      format.js { render :index }
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to blog_path(@blog), notice:"コメントを編集しました"
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def set_comment_blog
      @comment = Blog.find(params[:blog_id]).comments.find(params[:id])
      @blog = @comment.blog
    end
end
