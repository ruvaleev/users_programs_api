# frozen_string_literal: true

module ApiHelper
  def json_body
    JSON.parse(response.body)
  end
end
