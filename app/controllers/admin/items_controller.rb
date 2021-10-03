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
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :image, :description, :price_without_tax, :genre_id, :is_sale)
  end
  
end
