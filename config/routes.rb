Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
  
  get 'fruits/new_csv', to: 'fruits#new_csv'
  post 'fruits/create_csv', to: 'fruits#create_csv'
end
