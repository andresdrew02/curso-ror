Rails.application.routes.draw do
  # root "articles#index"
  post '/products', to: 'products#create'
  get '/products/new', to: 'products#new', as: :new_product
  get '/products',to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
end
