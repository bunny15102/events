module Api
  class HttpHelper
    METHODS = Set.new ["get", "post", "put", "delete", "patch"]

    def initialize(host_url, header)
      @conn=Faraday.new(host_url, headers: header) do |f|
        f.options[:open_timeout] = 1800
        f.options[:timeout] = 1800
        f.adapter Faraday.default_adapter
      end
    end

    %w[get post put delete patch].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        unless METHODS.include?(method)
          raise ArgumentError, "unknown http method: #{method}"
        end
        def #{method}(url, payload = nil, api_key = nil)
          response = @conn.#{method}(url) do |req|
            req.headers["Content-Type"] = "application/json"
            req.body = payload.to_json if payload.present?
          end
        end
      RUBY
    end
  end
end