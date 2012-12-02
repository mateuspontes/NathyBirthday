require 'rubygems'
require 'sinatra'
require 'twitter'
require 'koala'
require 'rack-flash'

require './facebook'

enable  :sessions
use Rack::Flash, :sweep => true

APP_ID = 310165569096886
APP_CODE = '089142fe2a6bd1f565bd93e6708bbb3d'

before do
  content_type "text/html", :charset => "utf-8"

  Twitter.configure do |config|
    config.consumer_key = 'epqYuepBTFAMQaaHzb1oJw'
    config.consumer_secret = 'kxMBKt1JIDSnsE1DPKLsYWXwt3YhKACBURamdQYbgHA'
    config.oauth_token = '15313517-OA4qjLDlyZw4CB7DyfVO9YQNkX94nAlVGoBptKENY'
    config.oauth_token_secret = 'xT6lWt29aPQf1yV6qXaiksITmOTUEBsBdPET7LNRg'
  end

  @graph = Koala::Facebook::API.new(session['access_token']) if session['access_token']
end

helpers do
  def flash_types
    [:success, :notice, :warning, :error]
  end
end

get '/' do
  erb :index
end

get '/post-twitter' do
  #Twitter.update("")
  flash[:success] = "Postado no twitter =)"
  redirect '/'
end

get '/post-facebook' do
  #@graph.put_picture("http://f.simplesideias.com.br/raby.jpg", {"message" => "Postando via Sinatra ;)"})
  flash[:success] = "Postado no facebook =)"
  redirect '/'
end

get '/post-photo-facebook' do
  erb :"fase2/post-photo-facebook"
end

post '/post-photo-facebook' do
  File.open('sample_fb.jpg', 'wb') do|f|
    f.write(Base64.decode64(params[:fbphoto]))
  end
  File.rename "./sample_fb.jpg", "./public/images/sample_fb.jpg"
  
  #@graph.put_picture("./public/images/sample_fb.jpg", {"message" => "Your smile makes me happy ;)"})
  flash[:success] = "A foto da webcam foi postada no facebook =)"
  redirect '/'
end

#["/foo", "/bar", "/baz"].each do |path|
#  get path do
#    "#{request.path_info}"
#  end
#end