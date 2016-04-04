def current_user
  @current_user ||= session[:user_id]
end

SAMPLE_COUNT = 10

get "/" do
  if current_user
    redirect "/favorites"
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

get "/auth/soundcloud/js/callback" do
  slim  :callback
end

get "/recommends" do
  if current_user
    @client = Soundcloud.new(:access_token => session[:oauth_token])
    @followings = @client.get("/me/followings")["collection"].sample(10)
    slim  :recommend
  else
    slim  :signon,:layout => false
  end
end

get "/favorites" do
  if current_user
    @client = Soundcloud.new(:access_token => session[:oauth_token])
    @favorites = @client.get('/me/favorites')
    slim  :favorite
  else
    slim  :signon,:layout => false
  end
end

get "/search" do
  if current_user
    @client = Soundcloud.new(:access_token => session[:oauth_token])
    slim  :search
  else
    slim  :signon,:layout => false
  end
end

post "/search" do
  if current_user
    @client = Soundcloud.new(:access_token => session[:oauth_token])
    @tracks = @client.get('/tracks', :q => params[:query],:limit => 20)
    slim  :search
  else
    slim  :signon,:layout => false
  end
end
