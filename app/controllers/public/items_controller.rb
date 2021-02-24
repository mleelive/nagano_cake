class Public::ItemsController < ApplicationController

  def index
    @active_items = Item.where(is_active: true).page(params[:page])
  end

  def show

    @item = Item.find(params[:id])
    @cart_item = CartItem.new

  end

end
