require 'api/iterable_http_helper'
module Events
  class Iterable
    def initialize(user)
      @user = user
      @api_helper = Api::IterableHttpHelper.new
    end

    def make_api_call
    end

    def create_payload 
    end
  end
end