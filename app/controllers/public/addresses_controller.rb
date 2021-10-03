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
  
  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :end_user_id)
  end
end
