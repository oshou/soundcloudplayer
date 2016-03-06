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

get "/signout" do
  session.clear
  redirect "/"
end

get "/auth/soundcloud/callback" do
  auth = request.env['omniauth.auth']
  session[:user_id] = auth['uid']
  session[:name] = auth['info']['name']
  session[:oauth_token] = auth['credentials']['token']
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  redirect "/"
end


get "/test" do
  slim  :test,:layout => false
end

get "/auth/soundcloud/js/callback" do
  slim  :callback
end

get "/recommends" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @followings = @client.get("/me/followings").[]("collection").sample(10)
  slim  :recommend
end

get "/favorites" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @favorites = @client.get('/me/favorites')
  binding.pry
  slim  :favorite
end

get "/search" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  slim  :search
end

post "/search" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @tracks = @client.get('/tracks', :q => params[:query],:limit => 20)
  slim  :search
end
