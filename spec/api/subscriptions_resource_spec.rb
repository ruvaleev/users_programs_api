# frozen_string_literal: true

require 'rails_helper'
require_relative 'api_shared_examples'

RSpec.describe SubscriptionsResource, type: :request do
  before do
    host! 'localhost:3000/api/'
  end

  describe 'POST subscriptions/create' do
    subject(:request) { post 'subscriptions/create', params: params }

    let(:program) { create(:program) }
    let(:user) { create(:user) }
    let(:params) { { program_id: program.id, user_id: user.id } }

    context "when subscription doesn't exists yet" do
      it_behaves_like 'creates_new_instance', Subscription
    end

    context 'when subscription already exists' do
      it_behaves_like 'reports_about_conflict', Subscription do
        let(:instance) { create(:subscription, params) }
        let(:error_message) { { 'user_id' => [I18n.t('subscription.already_exists')] } }
      end
    end
  end
end
