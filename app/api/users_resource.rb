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

    desc 'Get user info'

    params do
      optional :email, type: String, desc: "User's email"
      optional :name, type: String, desc: "User's name"
    end

    get '/' do
      user = User.find_by(params.select { |_key, value| value.present? })
      user.as_json || error!(I18n.t('users.not_found'), 404)
    end
  end
end
