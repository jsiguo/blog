class HomeController < ApplicationController
   #before_filter :authenticate_user! , :except => [:show]     #没有登录直接跳到登录界面
  def index
     @posts = Post.order("created_at desc").page(params[:page]).per(4)
      tag_cloud #加入标签云
     respond_to do |format|
     format.html # index.html.erb
    end
  end

    def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  def tag
       @posts= Post.tagged_with(params[:id])
  end

end
