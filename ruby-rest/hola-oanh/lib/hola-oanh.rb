require 'uri'
require 'net/http'

require 'yaml'
require 'json'
require 'erb'

# Call and create data for  author first
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

new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/_authors/'+ data["name"] +".md", new_msg)

puts new_msg

end

# Call and create data for post first
uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/blogs@nodes')
res = Net::HTTP.get_response(uri)

json = res.body if res.is_a?(Net::HTTPSuccess)

json = json.gsub("@", "")

my_hash = JSON.parse(json)

results = my_hash['results']

input = File.read("/Users/oanh.thai/git/oanhthai-cms/ruby-rest/templates/posts.md")
template = ERB.new(input, trim_mode: "%<>")

data = results

results.length.times do |i|

data = results[i]


new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/_posts/'+ Time.at(data["metadata"]["mgnl:lastModified"]).strftime("%Y-%m-%d-") + data["name"] +".md", new_msg)

puts new_msg

end

# Create navigation 

uri = URI('http://localhost:8080/container/.rest/delivery/pagenav/v1')
res = Net::HTTP.get_response(uri)

json = res.body if res.is_a?(Net::HTTPSuccess)


my_hash = JSON.parse(json)

data = my_hash['results'].to_yaml

new_msg = data.gsub("@", "")
new_msg = new_msg.gsub("\"", "")

File.write('/Users/oanh.thai/git/oanhthai-cms/_data/testnavigation.yml', new_msg)

puts new_msg 

# Add each pages

# index
uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/website/index')
res = Net::HTTP.get_response(uri)


json = res.body if res.is_a?(Net::HTTPSuccess)
data = JSON.parse(json)

input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/home.md")

template = ERB.new(input, trim_mode: "%<>")

new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/index.html', new_msg)

puts new_msg

#about
uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/website/about')
res = Net::HTTP.get_response(uri)


json = res.body if res.is_a?(Net::HTTPSuccess)
data = JSON.parse(json)

input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/about.md")

template = ERB.new(input, trim_mode: "%<>")

new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/about.md', new_msg)

puts new_msg

#post
uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/website/blog')
res = Net::HTTP.get_response(uri)


json = res.body if res.is_a?(Net::HTTPSuccess)
data = JSON.parse(json)

input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/blog.md")

template = ERB.new(input, trim_mode: "%<>")

new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/blog.html', new_msg)

puts new_msg

#staff

uri = URI('http://localhost:8080/container/.rest/delivery/norsu-demo/website/staff')
res = Net::HTTP.get_response(uri)


json = res.body if res.is_a?(Net::HTTPSuccess)
data = JSON.parse(json)

input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/staff.md")

template = ERB.new(input, trim_mode: "%<>")

new_msg = template.result(binding)

File.write('/Users/oanh.thai/git/oanhthai-cms/staff.html', new_msg)

puts new_msg

