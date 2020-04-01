# frozen_string_literal: true

Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/api/swagger'

  namespace 'api' do
    mount API => '/'
    mount GrapeSwaggerRails::Engine => '/swagger'
  end
end
