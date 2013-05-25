require 'net/http'
require 'json'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures'
  c.hook_into :webmock # or :fakeweb
  c.preserve_exact_body_bytes { false }
  c.default_cassette_options = {
    :serialize_with => :syck
  }
end

uri =  URI.parse('https://api.github.com/users/rodrigoflores/repos')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)

VCR.use_cassette('repos') do
  response = http.request(request)

  repos = JSON.parse(response.body)
  repos.each do |repo|
    puts repo['name']
  end
end