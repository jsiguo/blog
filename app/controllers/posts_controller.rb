class PostsController < ApplicationController
  before_filter :authenticate_user! , :except => [:show]     #没有登录直接跳到登录界面
  def index

        @search  = Post.search(params[:search])
        @posts = @search.all     #查出所有匹配的记录
        @posts = @search.page(params[:page]).per(2)
               if  params[:search]==nil
                 @posts = Post.where(:user_id=>current_user.id).page(params[:page]).per(2)
               end
       tag_cloud #加入标签云
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  def tag
       @posts= Post.tagged_with(params[:id])
end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    respond_to do |format|
        format.html
        format.js
      end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id=current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
