env = ENV["RACK_ENV"] || "development"
url = "sqlite://#{Dir.pwd}/db/#{env}.sqlite3"
#url = "mysql://user:password@localhost/dbname"
DataMapper.setup :default, url

class Image
	include DataMapper::Resource

	property :ind         , Serial
	property :title       , String
	property :url         , String , length: 0..250
	property :decription  , Text
end

DataMapper.finalize
DataMapper.auto_upgrade!