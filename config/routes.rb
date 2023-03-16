Rails.application.routes.draw do
  
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  devise_for :end_users, skip: :all
  devise_scope :end_user do
    get 'customers/sign_in' => 'end_users/sessions#new', as: 'new_end_user_session'
    post 'customers/sign_in' => 'end_users/sessions#create', as: 'end_user_session'
    delete 'customers/sign_out' => 'end_users/sessions#destroy', as: 'destroy_end_user_session'
    get 'customers/sign_up' => 'end_users/registrations#new', as: 'new_end_user_registration'
    post 'customers' => 'end_users/registrations#create', as: 'end_user_registration'
    get 'customers/password/new' => 'end_users/passwords#new', as: 'new_end_user_password'
  end
    
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resource :order_lists, only: [:show]
    end
    resources :order_details, only: [:update]
  end
  scope module: :public do
    root to: 'homes#top'
    get  "orders/confirm" => redirect("orders/new") #注文確認画面(orders/confirm)にてリロードした時の対策
    get 'customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    patch 'customers/withdrawal' => 'customers#out', as: 'out_withdrawal'
    resource :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :create,  :update, :destroy]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
