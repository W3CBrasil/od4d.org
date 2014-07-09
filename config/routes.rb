Rails.application.routes.draw do
  root :to => redirect('/index')
  get '/index' => 'pages#index'
  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'
  get '/how-to-create-a-semantic-page' => 'pages#how_to_create_a_semantic_page'
  get '/how-to-integrate' => 'pages#how_to_integrate_with_od4d'
  resources :articles, :only => [:index]
end
