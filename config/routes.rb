Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :documents
    resources :stats, only: :index
    resources :user_accounts
    resources :pdfs, only: :show
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'passwords/forgot', to: 'passwords#forgot'
  post 'passwords/reset', to: 'passwords#reset'
end
