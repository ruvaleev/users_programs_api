# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'creates_new_user' do
  it 'creates one new user' do
    expect { request }.to change(User, :count).by(1)
  end
  it 'create user with appropriate params' do
    request
    user = User.last
    expect([user.email, user.name]).to eq params.values
  end
  it 'returns successful status' do
    request
    expect(response).to have_http_status(:success)
  end
  it 'returns user as json in body' do
    request
    expect(JSON.parse(response.body)).to eq User.last.as_json
  end
end

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
      it_behaves_like 'creates_new_user'
    end
    context 'when user with the same name exists already' do
      let!(:user) { create(:user, name: name) }
      it_behaves_like 'creates_new_user'
    end

    context 'when user with same email found' do
      let!(:user) { create(:user, email: email) }
      let(:error_message) { { 'email' => ['has already been taken'] } }

      before { request }

      it 'returns 409 status' do
        expect(response).to have_http_status(409)
      end
      it "returns user's messages as json" do
        expect(JSON.parse(response.body)).to eq error_message
      end
    end
  end
end
