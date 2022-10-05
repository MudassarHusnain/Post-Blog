class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  def show
    @post=Post.find(params[:id])
    @comment=@post.comments.build
  end
  def create

    @post = Post.new(post_params)
    @post.user= current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @post=Post.find(params[:id])
  end
  def update
    @post=Post.find(params[:id])
    @posts=Post.all
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @post = Post.destroy(params[:id])

    redirect_to root_path, status: :see_other
  end
  protected
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
