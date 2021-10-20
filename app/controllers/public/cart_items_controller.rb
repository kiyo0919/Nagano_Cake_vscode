class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @cart_items = current_end_user.cart_items
  end
  
  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.end_user.id = current_end_user.id
    if current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item = current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
        cart_item.save
        flash[:notice] = "カート内商品の個数を変更しました。"
        redirect_to cart_items_path
    else
      cart_item = current_end_user.cart_items.new(cart_item_params)
      if cart_item.save
        flash[:notice] = "カートに商品を追加しました。"
        redirect_to cart_items_path
      else
        render item_path(item)
      end
    end
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      flash[:notice] = "商品の個数を変更しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "商品をカートから削除しました。"
    redirect_to cart_items_path
  end
  
  def destroy_all
    cart_items = CartItem.where(end_user_id: current_end_user.id)
    cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :end_user_id, :amount)
  end
end
