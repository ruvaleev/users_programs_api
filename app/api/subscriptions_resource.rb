# frozen_string_literal: true

class SubscriptionsResource < Grape::API
  namespace :subscriptions do
    desc 'Create subscription'

    params do
      requires :program_id, type: Integer, desc: "Program's id"
      requires :user_id, type: Integer, desc: "User's id"
    end

    post '/create' do
      subscription = Subscription.create(params)
      subscription.persisted? ? subscription.as_json : error!(subscription.errors.messages, 409)
    end
  end
end
