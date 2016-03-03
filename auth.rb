configure do
  set :sessions,true
  set :inline_templates,true
end

use OmniAuth::Builder do
  provider  "soundcloud",ENV['SOUNDCLOUD_CLIENT_ID'],ENV['SOUNDCLOUD_SECRET']
end
