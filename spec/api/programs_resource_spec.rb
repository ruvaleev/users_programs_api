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

  describe 'GET programs/autocomplete' do
    subject(:request) { get 'programs/autocomplete', params: params }

    let(:params) { { term: search_string } }
    let(:search_string) { FFaker::Lorem.characters(10) }

    context 'when programs found' do
      let(:top_rated_program) { create(:program, title: "Best #{search_string}", users_count: 2) }
      let(:low_rated_program) { create(:program, title: "Good #{search_string}", users_count: 1) }
      let!(:found_programs) { [low_rated_program, top_rated_program] }
      let!(:program_without_search_string) { create(:program) }

      before { request }

      it "doesn't return programs without search sting" do
        expect(response.body).to_not include program_without_search_string.title
      end
      it 'returns all programs with search string sorted by :users_count' do
        expect(JSON.parse(response.body)).to eq sorted_by_rating(found_programs).map(&:attributes)
      end
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when programs not found' do
      before { request }

      it "returns 'not found' message if no found results" do
        expect(JSON.parse(response.body)).to eq I18n.t('programs.not_found')
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end

private

def sorted_by_rating(programs)
  programs.sort { |x, y| y.users_count <=> x.users_count }
end
