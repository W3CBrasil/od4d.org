Rails.application.routes.draw do
  root 'home#index'

  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'

  get '/how-to-integrate' => 'pages#how_to_integrate_with_od4d'
  get '/introduction-to-rdf-and-rdfa' => 'pages#introduction_to_rdf_and_rdfa'
  get '/how-to-create-a-semantic-page' => 'pages#how_to_create_a_semantic_page'
  get '/glossary' => 'pages#glossary'

  resources :articles, :only => [:index]
  resources :cases, :only => [:index]
  resources :partners, :only => [:index]
end
