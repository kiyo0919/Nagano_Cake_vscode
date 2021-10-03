class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id]) 
    @user = @order.end_user
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if params[:order][:order_status] == "payment_confirmation"
    	  @order.order_details.each do |order_detail|
    	   		order_detail.production_status = "waiting_production"
    	   		order_detail.save
    	  end
      end
      flash[:notice] = "注文ステータスを更新しました。"
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
