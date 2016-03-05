DataMapper::Logger.new($stdout,:debug)

DataMapper.setup(:default,'mysql://'+ENV['DB_USER']+':'+ ENV['DB_PASSWORD']+'@'+ENV['DB_HOST']+'/'+ENV['DB_NAME'])

class Recommend
  include DataMapper::Resource
  property  :id,Serial
  property  :user_id,String
  property  :user_name,String
  property  :track_id,String
  property  :track_name,String
end

DataMapper.finalize.auto_upgrade!

