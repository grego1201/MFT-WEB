Rails.application.routes.draw do
  scope "(:locale)", locale: /es|en/ do
    get 'guided/index'
    get 'guided/results'
    post 'guided/index', to: 'guided#obtain_decision'
    #get 'guided/results', to: 'guided#show_results'
    get 'fill_fencer/index'
    get 'fill_fencer/results'
    post 'fill_fencer/index', to: 'fill_fencer#obtain_decision'
    get 'welcome/index'
    get 'contact/index'
    get 'show_suggests/index'
    post 'show_suggests/index', to: 'show_suggests#create_suggest'
    get 'training/index'
    post 'training/index', to: 'training#show_random'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    #
    root 'welcome#index'
  end
end
