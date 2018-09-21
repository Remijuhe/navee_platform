class PostsController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.search_by_city_and_status(params[:query])
    else
      @posts = Post.all
    end
  end
end

