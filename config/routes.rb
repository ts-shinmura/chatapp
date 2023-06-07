Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root redirect('/chats')

  post 'acs' => 'application#consume'

  resources :chats do
    resources :messages
  end
end
