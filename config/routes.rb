Rails.application.routes.draw do
  # root "articles#index"
  get '/products',to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
end
