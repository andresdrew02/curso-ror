Rails.application.routes.draw do
  # root "articles#index"
  post '/products', to: 'products#create'
  patch '/products/:id/edit', to: 'products#update'
  delete '/products/:id', to: 'products#destroy'
  get '/products/new', to: 'products#new', as: :new_product
  get '/products',to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
  get '/products/:id/edit', to: 'products#edit', as: :edit_product
end
