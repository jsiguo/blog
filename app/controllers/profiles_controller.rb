class ProfilesController < ApplicationController
       before_filter :authenticate_user! , :except => [:show]     #没有登录直接跳到登录界面
  def create
    @profile = @profile.users.create(params[:id])
   # @profile = @user.build_profile
    redirect_to post_path(@post)
  end

   def edit
    @profile = Profile.find(params[:id])
   end

  def new
  end

  def show
  end

   def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  end
