class CommentsController < ApplicationController
  before_filter :authenticate_user! , :except => [:show]     #没有登录直接跳到登录界面

def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    @comment.update_attributes(:user_id=>current_user.id)
      if   @comment.save
           @comment.countTest=comment_count
        respond_to do |format|
         format.js
         end
      end
end

def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
   # redirect_to post_path(@post)
     @comment.countTest=comment_count
  respond_to do |format|
      format.js
    end
end

  protected              #查询评论数量
   def comment_count
            @number=@post.comments.count
  end
end
