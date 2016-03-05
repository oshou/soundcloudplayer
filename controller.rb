private

def current_user
  @current_user ||= session[:user_id]
end

get "/" do
  if current_user
    redirect "/recommends"
  else
    slim  :signon,:layout => false
  end
end

get '/auth/soundcloud/callback' do
  auth = request.env['omniauth.auth']
  session[:user_id] = auth['uid']
  session[:name] = auth['info']['name']
  session[:oauth_token] = auth['credentials']['token']
  redirect "/"
end

get "/logout" do
  session.clear
  redirect "/"
end

get "/recommends" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @followings = @client.get('/me/followings')
  @recommends =
  slim  :recommend
end

get "/search" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  slim  :search
end

post "/search" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @tracks = @client.get('/tracks', :q => params[:query],:limit => 100)
  slim  :search
end

get "/favorites" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @favorites = @client.get('/me/favorites')
  slim  :favorite
end
