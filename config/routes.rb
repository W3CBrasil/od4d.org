Rails.application.routes.draw do
  root 'home#index'
  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'
  get '/how-to-create-a-semantic-page' => 'pages#how_to_create_a_semantic_page'
  get '/how-to-integrate' => 'pages#how_to_integrate_with_od4d'
  get '/how-to-new' => 'pages#how_to_new'
  get '/glossary' => 'pages#glossary'
  resources :articles, :only => [:index]
  resources :cases, :only => [:index]
end
