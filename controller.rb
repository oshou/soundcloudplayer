get "/" do
  if logged_in?
    slim  :signon,:layout => false
  else
    @client = Soundcloud.new(:access_token => session[:oauth_token])
    redirect "/recommendtracks"
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

get "/recommendtracks" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @folowings = @client.get('/users/"#{session[:user_id]}"/followings')
  slim  :index
  # フォローユーザー一覧を変数格納
  # フォローユーザーのライクをdb格納、上限値を設ける
  # フォローライクから上限20で格納
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

get "/playlists" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @tracks = @client.get('/me/favorites')
  slim  :playlist
end

private

def current_user
  return unless session[:user_id]
  @current_user ||= user.find(session[:user_id])
end

def logged_in?
  !!session[:user_id]
end

