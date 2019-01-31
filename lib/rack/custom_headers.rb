# frozen_string_literal: true

require "securerandom"

module Rack
  class CustomHeaders
    def initialize(app, header_config = {})
      @app = app
      @header_config = header_config
    end

    def call(env)
      status, headers, body = @app.call(env)

      @header_config.each do |name, func|
        if env.key?(name)
          headers[name] = env[name]
        else
          generator = func == :default ? -> { SecureRandom.uuid } : func
          headers[name] = generator.call
        end
      end

      [status, headers, body]
    end
  end
end
