require 'net/http'
require 'json'
require 'faraday'
require 'faraday_middleware'

conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
  faraday.adapter :test do |stub|
    stub.get('/users/rodrigoflores/repos') {[ 200, { 'Content-Type' => 'application/json; charset=utf-8' }, File.read('response.json') ]}
  end

  faraday.response :json, :content_type => /\bjson$/
end

repos = conn.get('/users/rodrigoflores/repos').body
repos.each do |repo|
  puts repo['name']
end