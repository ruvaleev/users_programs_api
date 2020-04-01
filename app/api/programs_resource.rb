# frozen_string_literal: true

class ProgramsResource < Grape::API
  namespace :programs do
    desc 'Get full program listing'

    get '/' do
      Program.all
    end
  end
end
