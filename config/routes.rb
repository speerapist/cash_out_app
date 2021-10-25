# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: 'api' do
    namespace :v1 do
      post 'cash_out', to: 'cash_out#update'
    end
  end
end
