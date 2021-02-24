class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
     @customer = Customer.find(params[:id])
    
  end
  
  def edit
   
      @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to customer_path(current_customer.id), notice: "登録情報を編集しました"
    else
       render :edit
    end
  end
  
  def quit
  
  end
  
  def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email)
  end
end
