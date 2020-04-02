# frozen_string_literal: true

class ProgramsResource < Grape::API
  namespace :programs do
    desc 'Get full program listing'

    get '/' do
      Program.all
    end

    desc 'Autucomplete by popular programs'

    params do
      requires :term, type: String, desc: "Chunk of program's title"
    end

    get '/autocomplete' do
      query = "title LIKE '%#{params[:term]}%'"
      programs = Program.where(query).order(users_count: :desc).limit(10)
      programs.presence || I18n.t('programs.not_found')
    end
  end
end
