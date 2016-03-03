DataMapper::Logger.new($stdout,:debug)

DataMapper.setup(:default,'mysql://'+ENV['DB_USER']+':'+ ENV['DB_PASSWORD']+'@'+ENV['DB_HOST']+'/'+ENV['DB_NAME'])

class User
  include DataMapper::Resource
  property  :id,Serial
  property  :uid,String
  property  :name,String
  property  :token,String
  property  :created_at,DateTime
end

DataMapper.finalize.auto_upgrade!

