Rails.application.routes.draw do
  root :to => redirect('/about')
  get '/about' => 'pages#about'
  get '/terms-and-conditions' => 'pages#terms_and_conditions'
  get '/how-to-create-a-semantic-page' => 'pages#how_to_create_a_semantic_page'
  resources :articles, :only => [:index]
end
