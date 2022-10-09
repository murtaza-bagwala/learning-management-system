# frozen_string_literal: true

JSONAPI.configure do |config|
  # Allowed values are :integer(default), :uuid, :string, or a proc
  config.resource_key_type = :uuid
  config.json_key_format = :underscored_key
  config.route_format = :underscored_route
  config.default_paginator = :paged

  config.default_page_size = 10
  config.maximum_page_size = 20

  config.exception_class_whitelist = [StandardError]
end
