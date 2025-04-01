Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :leaves do
      member do
        put :approve
        put :cancel
      end
    end
  end

  namespace :admin do
    resources :salaries do
      put :send_salary_email, on: :member
    end
  end

  resources :staffs, only: [] do
    post :check_in, on: :collection
    post :login, on: :collection
    delete :logout, on: :collection
    get :show_attendence, on: :collection
  end
    
  resources :holidays, only: [] do
    get :show_holidays, on: :collection
  end
    
end
