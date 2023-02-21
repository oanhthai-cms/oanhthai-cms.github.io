# navigation.rb
require 'uri'
require 'net/http'

require 'yaml'
require 'json'
require 'erb'

uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/authors@nodes')
res = Net::HTTP.get_response(uri)

json = res.body if res.is_a?(Net::HTTPSuccess)

json = json.gsub("@", "")

my_hash = JSON.parse(json)

results = my_hash['results']

input = File.read("/Users/oanh.thai/git/oanhthai-cms/ruby-rest/templates/authors.md")
template = ERB.new(input, trim_mode: "%<>")

data = results

results.length.times do |i|

data = results[i]

new_msg = template.result

File.write('/Users/oanh.thai/git/oanhthai-cms/_authors/'+ data["name"] +".md", new_msg)

puts new_msg

end
