class Public::DeliveriesController < ApplicationController

  before_action :authenticate_customer!


  def index
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @delivery = Delivery.new
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
 
    if @delivery.save
      redirect_to deliveries_path, success: "配送先の新規登録が完了しました。"
    else
      @deliveries = Delivery.where(customer_id: current_customer.id)
      render :index
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path
    else
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
  end

  protected

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end

end