class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all.page(params[:page]).per(10)
    @customer_orders = Order.where(customer_id: params[:customer_id])
    @customer = Customer.find_by(id: params[:customer_id])
  end


end
