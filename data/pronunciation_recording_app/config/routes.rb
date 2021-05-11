Rails.application.routes.draw do
  get '/sounds/:speaker_slug', to: 'sounds#index'
  resources :sounds
end
