require 'api/http_helper'
module Api
  class IterableHttpHelper < HttpHelper
    def initialize
      super(get_url, {'Api-Key' => ENV['iterable_api_key'] })
    end

    def get_url
      "https://api.iterable.com/api/"
    end
  end
end