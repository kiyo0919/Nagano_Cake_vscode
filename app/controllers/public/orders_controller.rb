class Public::OrdersController < ApplicationController
  def new
    if current_end_user.cart_items.present?
      @order = Order.new
      @user = current_end_user
    else
      flash[:notice] = "カートに商品を入れてください。"
      redirect_to cart_items_path
    end
  end
  
  def confirm
    if current_end_user.cart_items.present?
      @cart_items = current_end_user.cart_items
      @order = Order.new(order_params)
      if params[:order][:address_option] == "0"
        @order.postal_code = current_end_user.postal_code
        @order.address = current_end_user.address
        @order.name = current_end_user.last_name + current_end_user.first_name
      elsif params[:order][:address_option] == "1"
        address = Address.find(params[:address][:id]) # <%= f.select :address_id, options_from_collection_for_select( current_end_user.addresses, :id, :address_property)%>の場合、prams[:order][:address_id]となる
        @order.postal_code = address.postal_code
        @order.address = address.address
        @order.name = address.name
      elsif params[:order][:address_option] == "2"
        @address = Address.new
        @address.address = params[:order][:address]
        @address.name = params[:order][:name]
        @address.postal_code = params[:order][:postal_code]
        @address.end_user_id = current_end_user.id
        if @address.save
          @order.postal_code = @address.postal_code
          @order.name = @address.name
          @order.address = @address.address
        else
          render :new
        end
      end
      @sum = 0
      cart_items = current_end_user.cart_items
      cart_items.each do |cart_item|
        @sum += (cart_item.item.add_tax_price * cart_item.amount)
      end
      @sum += @order.postage
      @order.total_price = @sum
    else
      flash[:notice] = "カートに商品を入れてください。"
      redirect_to cart_items_path
    end
  end
  
  def create
    order = Order.new(order_params)
    order.end_user_id = current_end_user.id
    order.save
    current_end_user.cart_items.each do |cart_item|
      order_detail = order.order_details.new
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      order_detail.price = (cart_item.item.price_without_tax * 1.10).floor
      order_detail.save
    end
    current_end_user.cart_items.destroy_all
    redirect_to  thanks_path
  end
  
  def thanks
  end
  
  def index
    @orders = current_end_user.orders
  end
  
  def show
    @order = Order.find(params[:id])
    if @order.end_user != current_end_user
      redirect_to root_path
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_price)
  end
end
