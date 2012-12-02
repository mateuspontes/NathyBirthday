get '/login' do
  session['oauth'] = Koala::Facebook::OAuth.new(APP_ID, APP_CODE, 'http://localhost:3000/callback')
  redirect session['oauth'].url_for_oauth_code(:permissions => "publish_stream, photo_upload, offline_access")
end

get '/logout' do
  session['oauth'] = nil
  session['access_token'] = nil
  redirect '/'
end

get '/callback' do
  session['access_token'] = session['oauth'].get_access_token(params[:code])
  redirect '/'
end