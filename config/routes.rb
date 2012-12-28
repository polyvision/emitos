Emitos::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  match 'soundfile' => 'soundfile#index'
  match 'soundfile/create' => 'soundfile#create'

  match 'callbox' => 'callbox#index'
  match 'callbox/create' => 'callbox#create'
  match 'callbox/edit/:id' => 'callbox#edit'
  match 'callbox/update/:id' => 'callbox#update'
  match 'callbox/test_sound/:id' => 'callbox#test_sound', :format => :js

  root :to => "home#index"
  devise_for :users
  resources :users
end