Emitos::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  match 'api/callbox/activate/:id' => 'api#callbox_activate'
  match 'api/callbox/deactivate/:id' => 'api#callbox_deactivate'

  match 'market_setting' => 'market_setting#index'
  match 'market_setting/update' => 'market_setting#update'
  match 'market_setting/update_market_setting_week_day/:id' => 'market_setting#update_market_setting_week_day'
  match 'market_setting/market_setting_week_day/:id' => 'market_setting#market_setting_week_day'

  match 'marketing_call' => 'marketing_call#index'
  match 'marketing_call/new' => 'marketing_call#new'
  match 'marketing_call/create' => 'marketing_call#create'

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