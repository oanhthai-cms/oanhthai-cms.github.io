# about.rb
require 'uri'
require 'net/http'

require 'yaml'
require 'json'

require 'erb'


uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/website/staff')
res = Net::HTTP.get_response(uri)


json = res.body if res.is_a?(Net::HTTPSuccess)
data = JSON.parse(json)

input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/staff.md")

template = ERB.new(input, trim_mode: "%<>")

new_msg = template.result

File.write('/Users/oanh.thai/git/oanhthai-cms/staff.html', new_msg)

puts new_msg