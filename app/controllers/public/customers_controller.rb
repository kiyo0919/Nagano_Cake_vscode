class Public::CustomersController < ApplicationController
  before_action :authenticate_end_user!
  
  def show
    @user = current_end_user
  end
  
  def edit
    @user = current_end_user
  end
  
  def update
    @user = current_end_user
    if @user.update(end_user_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to customers_path
    else
      render :edit
    end
  end
  
  def withdrawal
    @user = current_end_user
  end
  
  def out
    @user = current_end_user
    @user.update(is_valid: true)
    reset_session #セッション情報を削除する
    redirect_to root_path
  end
  
  private
  
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana,
                                      :first_name_kana, :postal_code, :address, :phone_number, :email)
  end
  
end
