Emitos::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  match 'api/callbox/activate/:id' => 'api#callbox_activate'
  match 'api/callbox/deactivate/:id' => 'api#callbox_deactivate'

  match 'market_setting' => 'market_setting#index'

  match 'soundfile' => 'soundfile#index'
  match 'soundfile/create' => 'soundfile#create'
  match 'soundfile/delete/:id' => 'soundfile#delete'

  match 'callbox' => 'callbox#index'
  match 'callbox/create' => 'callbox#create'
  match 'callbox/edit/:id' => 'callbox#edit'
  match 'callbox/update/:id' => 'callbox#update'
  match 'callbox/test_sound/:id' => 'callbox#test_sound', :format => :js

  match 'home/active_call_boxes' => 'home#active_call_boxes'

  root :to => "home#index"
  devise_for :users
  resources :users
end