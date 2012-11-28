require 'rubygems'
require 'sinatra'
require 'twitter'
require 'koala'
#require 'fb_graph'

enable  :sessions

before do
  content_type "text/html", :charset => "utf-8"
end

get '/' do
  erb :index
end

get '/post-twitter' do
  Twitter.configure do |config|
    config.consumer_key = 'epqYuepBTFAMQaaHzb1oJw'
    config.consumer_secret = 'kxMBKt1JIDSnsE1DPKLsYWXwt3YhKACBURamdQYbgHA'
    config.oauth_token = '15313517-OA4qjLDlyZw4CB7DyfVO9YQNkX94nAlVGoBptKENY'
    config.oauth_token_secret = 'xT6lWt29aPQf1yV6qXaiksITmOTUEBsBdPET7LNRg'
  end

  Twitter.update("Postando mensagem via Sinatra + Twitter ;)")

  puts "# postado no twitter =)"
  redirect '/'
end

get '/post-facebook' do
  @graph = Koala::Facebook::API.new('AAAEaGAyRTLYBABJhZAZCeNLqpGnglWrhsWCjH84sR6pV21pZB6GlUnZAYn6boquZAQ3OxUzTI7RodpxhseEsM8CzDyCzN2LijicqG2a5T3Hit2sU4PA4A')
  #@graph.put_picture("http://f.simplesideias.com.br/raby.jpg", {"message" => "Postando via Sinatra ;)"})
  @graph.put_picture("http://www.serieslider.com/wp-content/uploads/2012/05/homeland-tv-movie-poster-2011-1010714360.jpg", {"message" => "Homeland S02E09 > http://www.serieslider.com/download/homeland/"})

  puts "# postado no facebook =)"
  redirect '/'
end
