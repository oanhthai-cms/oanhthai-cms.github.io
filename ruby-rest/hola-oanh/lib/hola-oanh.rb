require 'uri'
require 'net/http'
require 'yaml'
require 'json'
require 'erb'

# Create a func
# Creating a Function
def myFunc(url, templateFile)
   
uri = URI(url)
res = Net::HTTP.get_response(uri)
json = res.body if res.is_a?(Net::HTTPSuccess)
json = json.gsub("@", "")
my_hash = JSON.parse(json)
results = my_hash['results']
input = File.read(templateFile)
template = ERB.new(input, trim_mode: "%<>")
data = results
results.length.times do |i|
    data = results[i]
    new_msg = template.result(binding)
    File.write('/Users/oanh.thai/git/oanhthai-cms/_authors/'+ data["short_name"] +".md", new_msg) 
puts new_msg
    end
end

# Calling the function create author
value = myFunc('http://localhost:8080/container/.rest/delivery/jekyll-demo/authors@nodes',"/Users/oanh.thai/git/oanhthai-cms/ruby-rest/templates/authors.md")

# Call and create data for post first
uri = URI('http://localhost:8080/container/.rest/delivery/jekyll-demo/blogs@nodes')
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
uri = URI('http://localhost:8080/container/.rest/delivery/jekyllnav/v1')
res = Net::HTTP.get_response(uri)
json = res.body if res.is_a?(Net::HTTPSuccess)
navs = JSON.parse(json)
navsResults = navs['results']
data = navsResults.to_yaml
new_msg = data.gsub("@", "")
new_msg = new_msg.gsub("\"", "")
File.write('/Users/oanh.thai/git/oanhthai-cms/_data/testnavigation.yml', new_msg)
puts navsResults 

# Create each pages
navsResults.length.times do |i|

    data = navsResults[i]
    name = data["@name"].to_s
    uri = URI('http://localhost:8080/container/.rest/delivery/jekyll-demo/website/'+name)
    res = Net::HTTP.get_response(uri)
    json = res.body if res.is_a?(Net::HTTPSuccess)
    data = JSON.parse(json)
    exist = File.exists?("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/"+name+".md")
    if(exist)
        input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/"+name+".md")
    else
        input = File.read("/Users/oanh.thai/git/oanhthai-cms/modules/jekyll-demo/dialogs/pages/default.md")
    end

    template = ERB.new(input, trim_mode: "%<>")
    new_msg = template.result(binding)
    File.write("/Users/oanh.thai/git/oanhthai-cms/"+name+".html", new_msg)
    puts new_msg 
    
end


