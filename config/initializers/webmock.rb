if Rails.env.development? or Rails.env.test?
  require 'webmock'
  include WebMock::API
  WebMock.enable!
  
  # Stub requests to Iterable API
  stub_request(:post, "https://api.iterable.com/api/events/trackWebPushClick")
    .to_return(status: 200, body: '{"code": "Success"}')

  stub_request(:post, "https://api.iterable.com/api/email/target")
    .to_return(status: 200, body: '{"code": "Success"}')
end