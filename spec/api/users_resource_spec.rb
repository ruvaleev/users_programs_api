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
      let(:error_message) { { 'error' => I18n.t('users.not_found') } }

      before { request }

      it 'returns 404 status' do
        expect(response).to have_http_status(404)
      end
      it "returns 'not found' message" do
        expect(JSON.parse(response.body)).to eq error_message
      end
    end
  end
end
