Rails.application.routes.draw do
  # root "articles#index"
  get '/products',to: 'products#index'
end
