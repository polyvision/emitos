Emitos::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  match 'api/callbox/activate/:id' => 'api#callbox_activate'
  match 'api/callbox/deactivate/:id' => 'api#callbox_deactivate'
  match 'api/cycle' => 'api#cycle'

  match 'system' => 'setting#index'
  match 'system/update' => 'setting#update'

  match 'market_setting' => 'market_setting#index'
  match 'market_setting/update' => 'market_setting#update'
  match 'market_setting/update_market_setting_week_day/:id' => 'market_setting#update_market_setting_week_day'
  match 'market_setting/market_setting_week_day/:id' => 'market_setting#market_setting_week_day'

  match 'marketing_call' => 'marketing_call#index'
  match 'marketing_call/new' => 'marketing_call#new'
  match 'marketing_call/create' => 'marketing_call#create'
  match 'marketing_call/edit/:id' => 'marketing_call#edit'
  match 'marketing_call/update/:id' => 'marketing_call#update'
  match 'marketing_call/delete/:id' => 'marketing_call#delete'

  match 'soundfile' => 'soundfile#index'
  match 'soundfile/create' => 'soundfile#create'
  match 'soundfile/delete/:id' => 'soundfile#delete'

  match 'statistic' => 'statistic#index'
  match 'statistic/common' => 'statistic#common'
  match 'statistic/single' => 'statistic#single'
  match 'statistic/daily' => 'statistic#daily'

  match 'callbox' => 'callbox#index'
  match 'callbox/create' => 'callbox#create'
  match 'callbox/edit/:id' => 'callbox#edit'
  match 'callbox/update/:id' => 'callbox#update'
  match 'callbox/delete/:id' => 'callbox#delete'
  match 'callbox/test_sound/:id' => 'callbox#test_sound', :format => :js
  match 'callbox/test_activate/:id' => 'callbox#test_activate', :format => :js
  match 'callbox/test_deactivate/:id' => 'callbox#test_deactivate', :format => :js

  match 'users' => 'users#index'
  match 'users/new' => 'users#new'
  match 'users/create' => 'users#create'
  match 'users/edit/:id' => 'users#edit'
  match 'users/update/:id' => 'users#update'
  match 'users/delete/:id' => 'users#destroy'

  match 'backup' => 'backup#index'
  match 'backup/download' => 'backup#download'

  match 'home/active_call_boxes' => 'home#active_call_boxes'

  root :to => "home#index"
  devise_for :users
end