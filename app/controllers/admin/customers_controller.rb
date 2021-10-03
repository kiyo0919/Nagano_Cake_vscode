class Admin::CustomersController < ApplicationController
  
  def index
    @users = EndUser.all
  end
end
