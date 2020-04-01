# frozen_string_literal: true

require 'rails_helper'
require_relative 'api_shared_examples'

RSpec.describe UsersResource, type: :request do
  before do
    host! 'localhost:3000/api/'
  end

  describe 'POST users/create' do
    subject(:request) { post 'users/create/', params: params }

    let(:email) { FFaker::Internet.email }
    let(:name) { FFaker::Name.name }
    let(:params) { { email: email, name: name } }

    context "when user doesn't exist yet" do
      it_behaves_like 'creates_new_instance', User
    end
    context 'when user with the same name exists already' do
      let!(:user) { create(:user, name: name) }
      it_behaves_like 'creates_new_instance', User
    end

    context 'when user with same email found' do
      it_behaves_like 'reports_about_conflict', User do
        let(:instance) { create(:user, email: email) }
        let(:error_message) { { 'email' => ['has already been taken'] } }
      end
    end
  end

  describe 'GET users/' do
    subject(:request) { get 'users/', params: params }

    let(:email) { FFaker::Internet.email }
    let(:name) { FFaker::Name.name }
    let(:params) { { email: email, name: name } }

    context 'when user found' do
      let!(:user) { create(:user, params) }

      before { request }

      it 'returns user as json in body' do
        expect(JSON.parse(response.body)).to eq user.as_json
      end
      it 'returns successful status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not found' do
      it_behaves_like 'reports_about_not_found', I18n.t('users.not_found')
    end
  end

  describe 'GET users/subscriptions' do
    subject(:request) { get 'users/subscriptions', params: params }

    let(:params) { { id: user.id } }
    let(:user) { create(:user) }

    context 'when user subscribed' do
      let(:subscribed_programs) { create_list(:program, 2) }
      let(:unsubscribed_program) { create(:program) }

      before do
        user.programs << subscribed_programs
        request
      end

      it 'returns all programs provided user subscribed to' do
        expect(subscribed_programs.map { |program| response.body.include?(program.to_json) }.uniq).to eq [true]
      end
      it "doesn't return programs provided user not subscribed to" do
        expect(response.body.include?(unsubscribed_program.to_json)).to be_falsy
      end
      it 'returns successful status' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'when user has no subscriptions' do
      before { request }

      it 'returns empty array if user have no subscriptions' do
        expect(response.body).to eq '[]'
      end
      it 'returns successful status' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'when user not found' do
      let(:params) { { id: 0 } }
      it_behaves_like 'reports_about_not_found', I18n.t('users.not_found')
    end
  end
end
