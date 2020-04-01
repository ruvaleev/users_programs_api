# frozen_string_literal: true

class UsersResource < Grape::API
  namespace :users do
    desc 'Create users'

    params do
      requires :email, type: String, desc: "User's email"
      requires :name, type: String, desc: "User's name"
    end

    post '/create' do
      user = User.create(params)
      user.persisted? ? user.as_json : error!(user.errors.messages, 409)
    end
  end
end
