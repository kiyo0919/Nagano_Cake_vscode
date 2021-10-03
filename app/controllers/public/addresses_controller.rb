class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.where(end_user_id: current_end_user.id)
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    @address.end_user_id = current_end_user.id
    if @address.save
      flash[:notice] = "新規配送先を追加しました。"
      redirect_to addresses_path
    else
      render :index
    end
  end
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.end_user = current_end_user
      @address.update(address_params)
      flash[:notice] = "配送先を編集しました。"
      redirect_to addresses_path
    else
      render root_path
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :end_user_id)
  end
end
