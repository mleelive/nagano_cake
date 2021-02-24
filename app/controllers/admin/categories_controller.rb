class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
    redirect_to new_admin_category_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    redirect_to new_admin_category_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
