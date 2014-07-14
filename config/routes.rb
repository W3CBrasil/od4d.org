Rails.application.routes.draw do
  root 'home#index'

  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'

  get '/learn/how-to-integrate' => 'learn#how_to_integrate_with_od4d'
  get '/learn/introduction-to-rdf-and-rdfa' => 'learn#introduction_to_rdf_and_rdfa'
  get '/learn/how-to-create-a-semantic-page' => 'learn#how_to_create_a_semantic_page'
  get '/learn/glossary' => 'learn#glossary'

  resources :articles, :only => [:index]
  resources :cases, :only => [:index]
  resources :partners, :only => [:index]
end
