# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProgramsResource, type: :request do
  before do
    host! 'localhost:3000/api/'
  end

  describe 'GET programs/' do
    subject(:request) { get 'programs/' }

    let!(:programs) { create_list(:program, 3) }

    it 'returns all programs' do
      request
      expect(programs.map { |program| response.body.include?(program.to_json) }.uniq).to eq [true]
    end
  end
end
