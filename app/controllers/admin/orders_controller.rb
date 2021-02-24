class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
    @total_price = @order_items.sum{|order_item|(order_item.price).round * order_item.amount }
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.update(order_params)
    if @order.status == "入金待ち"
       @order_items.update_all(making_status: 0)
    elsif @order.status == "入金確認"
      @order_items.update_all(making_status: 1)
    end
     redirect_to admin_order_path(@order)
  end

  protected
  def order_params
    params.require(:order).permit(:status)
  end
end