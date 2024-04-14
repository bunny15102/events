require 'rails_helper'
require 'api/http_helper'

RSpec.describe Api::HttpHelper do
  let(:host_url) { 'https://example.com/' }
  let(:header) { { 'Api-Key' => 'test', 'User-Agent' => 'Faraday v2.9.0' } }
  let(:http_helper) { described_class.new(host_url, header) }
  response = Faraday::Response.new
  
  describe 'initialize' do
    it 'sets up a Faraday connection with the provided host_url and headers' do
      expect(http_helper.instance_variable_get(:@conn)).to be_a(Faraday::Connection)
      expect(http_helper.instance_variable_get(:@conn).headers).to eq(header)
      expect(http_helper.instance_variable_get(:@conn).url_prefix.to_s).to eq(host_url)
    end
  end
  
  describe 'HTTP methods' do
    let(:url) { '/path/to/resource' }
    let(:payload) { { key: 'value' } }
    
    %w[get post put delete patch].each do |method|
      describe "##{method}" do
        it "sends a #{method.upcase} request with correct headers and payload" do
          expect(http_helper.instance_variable_get(:@conn)).to receive(method.to_sym).with(url) do |_, &block|
            request = double('request')
            expect(request).to receive(:headers).and_return({})
            expect(request).to receive(:body=).with(payload.to_json)
            block.call(request)
          end.and_return(double('response', body: '{}'))
          
          response = http_helper.send(method.to_sym, url, payload)
          allow(response).to receive(:body).and_return('{}')
        end
        
        it "raises ArgumentError if unknown HTTP method is called" do
          expect { http_helper.send(:unknown_method, url) }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
