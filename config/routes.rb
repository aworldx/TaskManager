# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root to: 'welcome#index'

    namespace :admin do
      resources :tasks, only: :index
    end

    resources :tasks do
      scope module: :tasks do
        Task.aasm.events.each do |state|
          next if state.options[:initial]
          resource state.name, controller: state.name, only: :create
        end
      end
    end

    get    '/login', to: 'sessions#new'
    post   '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
end
