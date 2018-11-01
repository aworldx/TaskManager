# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root to: 'welcome#index'

    namespace :admin do
      resources :tasks, only: %I[index]
    end

    resources :tasks

    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
  end
end
