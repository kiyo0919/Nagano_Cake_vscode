class Admin::ItemsController < ApplicationController

  def index
    if params[:name].present?
      @items = Item.where( 'name LIKE ?', "%#{params[:name]}%" )
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新商品を登録しました。"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を編集しました。"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :image, :description, :price_without_tax, :genre_id, :is_sale)
  end
  
end
