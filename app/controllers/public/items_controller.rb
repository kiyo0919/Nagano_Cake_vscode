class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id].present?
      genre = Genre.find(params[:genre_id])
      @items = genre.items
      unless @items.present?
        flash[:notice] = "#{genre.name}の商品はございません。"
        redirect_to items_path
      end
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
