# frozen_string_literal: true

require 'grape-swagger'

class API < Grape::API
  content_type :json, 'application/json; charset=UTF-8'
  format :json

  before { header 'Content-Type', 'application/json; charset=utf-8' }

  mount UsersResource

  add_swagger_documentation format: :json,
                            hide_documentation_path: true,
                            mount_path: 'swagger_doc'
end
