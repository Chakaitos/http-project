require 'unirest'

module MakerBlog
  class Client
    def list_posts
      response = Unirest.get('http://makerblog.herokuapp.com/posts',
        headers: { "Accept" => "application/json" })
      posts = response.body
      posts.each do |post|
        puts "#{post['name']} \t#{post['title']} \t#{post['content']}"
      end
    end

    def show_post(id)
		  # hint: URLs are strings and you'll need to append the ID
		  url = "http://makerblog.herokuapp.com/posts/#{id}"

		  response = Unirest.get(url,
		    headers: { "Accept" => "application/json" })
		  post = response.body
		  puts "#{post['name']} \t#{post['title']} \t#{post['content']}"
		end

		def create_post(name, title, content)
		  url = "http://makerblog.herokuapp.com/posts/"
		  payload = {:post => {'name' => name, 'title' => title, 'content' => content}}

		  response = Unirest.post(url,
		    headers: { "Accept" => "application/json",
		               "Content-Type" => "application/json" },
		    parameters: payload)

		  post = response.body
		  puts "#{post['name']} \t#{post['title']} \t#{post['content']}"
		end

		def edit_post(id, options = {})
		  url = "http://makerblog.herokuapp.com/posts/#{id}"
		  params = {}

		  # can't figure this part out? Google "ruby options hash"
		  params[:name] = options[:name] unless options[:name].nil?
		  params[:title] = options[:title] unless options[:title].nil?
		  params[:content] = options[:content] unless options[:content].nil?

		  response = Unirest.put(url,
		    parameters: { :post => params },
		    headers: { "Accept" => "application/json",
		               "Content-Type" => "application/json" })

		  post = response.body
		  puts "#{post['name']} \t#{post['title']} \t#{post['content']}"
		end

		def delete_post(id)
		  url = "http://makerblog.herokuapp.com/posts/#{id}"
		  response = Unirest.delete(url,
		    headers: { "Accept" => "application/json" })
		  puts response.code
		end
  end
end

client = MakerBlog::Client.new
# client.list_posts
# client.show_post(18864)
# client.create_post("Drew", "Drew gaming abilities", "Drew's good at mario cart!")
# client.edit_post(18902, name: "Parth", title: "Parth gaming abilities", content: "Parth's good at mario cart!")
# client.delete_post(18902)