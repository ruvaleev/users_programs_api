# frozen_string_literal: true

unless ENV['ASSETS_PRECOMPILE'].present?
  GrapeSwaggerRails.options.url = '/swagger_doc'
  GrapeSwaggerRails.options.app_url = Settings.api.url
end
