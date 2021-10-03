class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    if params[:order_detail][:production_status] == "now_production"
      order_detail.order.order_status = "in_production"
      order_detail.order.save
    elsif order_detail.order.order_details.count == order_detail.order.order_details.where(production_status: "finish_production").count
      order_detail.order.order_status = "preparing_for_shipping"
      order_detail.order.save
    end
    flash[:notice] = "製作ステータスを更新しました。"
    redirect_to admin_order_path(order_detail.order)
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
