# frozen_string_literal: true

RSpec.shared_examples 'creates_new_instance' do |instance_class|
  it "creates one new #{instance_class.name.downcase}" do
    expect { request }.to change(instance_class, :count).by(1)
  end
  it "create #{instance_class.name.downcase} with appropriate params" do
    request
    instance = instance_class.last
    instance_params = instance.attributes.symbolize_keys.select { |key, _value| params.keys.include?(key) }
    expect(instance_params).to eq params
  end
  it 'returns successful status' do
    request
    expect(response).to have_http_status(:success)
  end
  it "returns #{instance_class.name.downcase} as json in body" do
    request
    expect(JSON.parse(response.body)).to eq instance_class.last.as_json
  end
end

RSpec.shared_examples 'reports_about_conflict' do |instance_class|
  before do
    instance
    request
  end

  it "doesn't create new #{instance_class.name.downcase}" do
    expect { request }.not_to change(instance_class, :count)
  end
  it 'returns 409 status' do
    expect(response).to have_http_status(409)
  end
  it 'returns error message as json' do
    expect(JSON.parse(response.body)).to eq error_message
  end
end

RSpec.shared_examples 'reports_about_not_found' do |error|
  let(:error_message) { { 'error' => error } }
  before { request }

  it 'returns 404 status' do
    expect(response).to have_http_status(404)
  end
  it "returns 'not found' message" do
    expect(JSON.parse(response.body)).to eq error_message
  end
end
