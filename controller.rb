configure do
  enable  :sessions
  set     :inline_templates,true
end

get "/" do
  if current_user
    @name = session[:user_id]
    slim  :index
  else
    slim  :signon,:layout => false
  end
end

get "/signon" do
  redirect "/auth/soundcloud"
end

get "/logout" do
  session.clear
  redirect "/"
end

get '/auth/soundcloud/callback' do
  auth = request.env['omniauth.auth']
  user = User.first_or_create({:uid => auth["uid"]},{
    :uid => auth["uid"],
    :name => auth["username"],
    :token => auth["token"],
    :created_at => Time.now
  })
  session[:user_id] = user.id
  redirect "/"
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end

get "/recommendtracks" do
  slim  :index
  # フォローユーザー一覧を変数格納
  # フォローユーザーのライクをdb格納、上限値を設ける
  # フォローライクから上限20で格納
end

get "/search" do
  # search.slimにジャンプ
end

get "/playlists" do
  # playlists.slimにジャンプ
end
