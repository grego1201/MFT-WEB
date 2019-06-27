Rails.application.routes.draw do
  get 'guided/index'
  post 'guided/index', to: 'guided#obtain_decision'
  #get 'guided/results', to: 'guided#show_results'
  get 'fill_fencer/index'
  post 'fill_fencer/index', to: 'fill_fencer#obtain_decision'
  get 'welcome/index'
  get 'contact/index'
  post 'contact/index', to: 'contact#create_suggest'
  get 'show_suggests/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'welcome#index'
end
