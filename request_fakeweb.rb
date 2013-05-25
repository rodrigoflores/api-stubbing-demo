# encoding: utf-8
require 'vcr'
require 'net/http'
require 'json'
require 'webmock'

include WebMock::API

stub_request(:get, "https://api.github.com/users/rodrigoflores/repos").to_return(body: File.read('response.json'))

uri =  URI.parse('https://api.github.com/users/rodrigoflores/repos')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)

repos = JSON.parse(response.body)
repos.each do |repo|
  puts repo['name']
end