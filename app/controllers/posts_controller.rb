class PostsController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.search_by_city_and_status(params[:query])
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(review_params)
    @post.save
    redirect_to post_path(@post.id)
  end

  private

  def review_params
    params.require(:post).permit([:status, :city, :rent_with_expenses_amount, :user_id, :description, :firstname, :lastname, :property_surface, :coordinates, :address, :pictures, :rooms_count, :zip_code])
  end
end
