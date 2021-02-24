class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
    @customer = current_customer
    @cart_item = @customer.cart_items.new(cart_item_params)
    @now_cart_item = @customer.cart_items.find_by(item_id: @cart_item.item_id)
     if @now_cart_item && @cart_item.amount.to_i >= 1

       @now_cart_item.amount += @cart_item.amount
       @now_cart_item.update(amount: @now_cart_item.amount)
       redirect_to cart_items_path
     
     else
        if @cart_item.save
        redirect_to cart_items_path
       
        else
         flash[:alert] = "カートに入れる個数を入力してください"
         redirect_back(fallback_location: cart_items_path)
        end

     end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end

end
