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

get "/auth/soundcloud/callback" do
  auth = request.env['omniauth.auth']
  session[:user_id] = auth['uid']
  session[:name] = auth['info']['name']
  session[:oauth_token] = auth['credentials']['token']
  redirect "/"
end

get "/recommends" do
  @client = Soundcloud.new(:access_token => session[:oauth_token])
  @followings = @client.get("/me/followings").[]("collection")
  @followings.each do |following|
    @following_favorites= @client.get("/users/#{following.id}/favorites")
    @following_favorites.each do |following_favorite|
      Recommend.create(
        :user_id => following.id,
        :user_name => following.username,
        :track_id => following_favorite.id,
        :track_name => following_favorite.title
      )
    end
  end
  @Recommends = Recommend.all
  binding.pry
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
  binding.pry
  slim  :favorite
end
