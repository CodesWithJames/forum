Rails.application.routes.draw do
  root 'topics#index'

  get 'login' => 'users#login', as: :login
  get 'logout' => 'users#logout', as: :logout
  get 'new-account' => 'users#new', as: :new_account
  post 'authenticate' => 'users#authenticate', as: :authenticate

  resources :users, except: [:destroy, :new]

  post '/topic' => 'topics#create', as: :create_topic
  post 'topic/comment' => 'topics#comment', as: :comment_topic
  get  'topic/new' => 'topics#new', as: :new_topic
  get  'topic/:id' => 'topics#view', as: :show_topic
end
