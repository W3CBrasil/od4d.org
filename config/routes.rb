Rails.application.routes.draw do

	#Casein routes
	namespace :casein do
		resources :languages
		resources :post_sections
		resources :posts
  end

  root 'home#index'

  get '/change_locale' => 'home#change_locale'

  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'
  get '/style-guide' => 'pages#style_guide'
  get '/privacy-policy' => 'pages#privacy_policy'
  get '/become-partner' => 'pages#become_partner'
  get '/become-contributor' => 'pages#become_contributor'

  get '/learn/how-to-integrate' => 'learn#how_to_integrate_with_od4d'
  get '/learn/introduction-to-rdf-and-rdfa' => 'learn#introduction_to_rdf_and_rdfa'
  get '/learn/how-to-create-a-semantic-page' => 'learn#how_to_create_a_semantic_page'
  get '/learn/glossary' => 'learn#glossary'
  get '/learn/concepts' => 'learn#concepts'
  get '/learn/ref-material' => 'learn#ref_material'
  get '/learn/capacity-building' => 'learn#capacity_building'

  get '/article' => 'articles#show'

  get '/posts/:id' => 'casein/posts#show'

  get '/articles/filter/:field/:term' => 'articles#filter'

  resources :articles, :only => [:index]
  resources :cases, :only => [:index]
  resources :partners, :only => [:index]
end
