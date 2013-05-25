require 'net/http'
require 'json'
require 'faraday'
require 'faraday_middleware'

conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
  faraday.adapter Faraday.default_adapter

  faraday.response :json, :content_type => /\bjson$/
end

repos = conn.get('/users/rodrigoflores/repos').body
repos.each do |repo|
  puts repo['name']
end