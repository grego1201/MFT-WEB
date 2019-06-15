Rails.application.routes.draw do
  get 'guided/index'
  post 'guided/index', to: 'guided#obtain_decision'
  #get 'guided/results', to: 'guided#show_results'
  get 'fill_fencer/index'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'welcome#index'
end
