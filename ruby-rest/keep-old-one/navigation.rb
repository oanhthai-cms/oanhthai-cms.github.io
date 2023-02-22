# navigation.rb
require 'uri'
require 'net/http'

require 'yaml'
require 'json'

uri = URI('http://localhost:8080/container/.rest/delivery/jekyllnav/v1')
res = Net::HTTP.get_response(uri)

json = res.body if res.is_a?(Net::HTTPSuccess)


my_hash = JSON.parse(json)

data = my_hash['results'].to_yaml

new_msg = data.gsub("@", "")
new_msg = new_msg.gsub("\"", "")

File.write('/Users/oanh.thai/git/oanhthai-cms/_data/testnavigation.yml', new_msg)

puts new_msg 