Rails.application.routes.draw do
  # resources :groups, except: [:new, :edit]
  scope '/api' do
    resources :groups, except: [:new, :edit]
    # post 'sign_up' => 'users#create'
    # post 'sign_in' => 'sessions#create'
    
  end


  match "*path" => "application#cors_preflight_check", :via => [:options]
  # get '*any' => 'application#options', :via => [:options]
  # get "*all" => "application#cors_preflight_check", :constraints => { :method => "OPTIONS" }
  namespace :api do
    namespace :v1 do
      post 'sign_up' => 'users#create'
      post 'sign_in' => 'sessions#create'
      post 'forgot_password' => 'users#forgot_password'
      delete 'sign_out/:id' => 'sessions#destroy'
    end
  end
end
