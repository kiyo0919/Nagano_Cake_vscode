class Admin::CustomersController < ApplicationController
  
  def index
    @users = EndUser.all
  end

  def show
    @user = EndUser.find(params[:id])
  end

  def edit
    @user = EndUser.find(params[:id])
  end

  def update
    @user = EndUser.find(params[:id])
    if @user.update(end_user_params)
      @user.save
      redirect_to admin_customer_path(@user)
    else
      render :edit
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code,
                                        :address, :phone_number, :email, :is_valid)
  end
end
