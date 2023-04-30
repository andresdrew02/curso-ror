Rails.application.routes.draw do
  resources :categories
  # root "articles#index"
  #post '/products', to: 'products#create'
  #   patch '/products/:id', to: 'products#update'
  #   delete '/products/:id', to: 'products#destroy'
  #   get '/products/new', to: 'products#new', as: :new_product
  #   get '/products',to: 'products#index'
  #   get '/products/:id', to: 'products#show', as: :product
  #   get '/products/:id/edit', to: 'products#edit', as: :edit_product

  #el desglose de arriba son las mismas rutas creadas por la funcion resources
  #path:'/' hace que las rutas de products, (/products) resida en el root
  resources :products, path:'/'
end
