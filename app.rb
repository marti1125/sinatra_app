require "sinatra/base"

IMAGES = [
	{title: "gunbound", url:"http://media.giantbomb.com/uploads/0/6017/396592-gunbound_recensione_pc_t5_large.jpg"},
	{title: "navyfield", url:"http://i2.fastpic.ru/big/2011/0514/75/2bea82b8aa7822705e3d215b06df5075.jpg"},
	{title: "hon", url:"http://www.hon-utilities.com/wp-content/uploads/2010/05/tundra-hon-guide-release.jpg"},
]

class App < Sinatra::Base

	enable :sessions

	before /images/ do
		@message = "You're viewing an image."
	end
	
	before do
		@user = "Willy Aguirre"
		@height = session[:height]
		logger = Log4r::Logger["app"]
		logger.info "==> Entering request"
	end
	
	after do
		logger = Log4r::Logger["app"]
		logger.info "<== Leaving request"
	end

	get '/sessions/new' do
		erb :"sessions/new"
	end

	post '/sessions' do
		session[:height] = params[:height]
		puts request.inspect
	end
	
	get '/images' do
		@images = IMAGES
		erb :images
	end
	
	get '/images/:index' do |index|
		index = index.to_i
		@image = IMAGES[index]
		
		haml :"images/show", layout: true
	end
	
	get '/' do
		erb :hello, layout: true
	end
	
	post '/' do
		"Hello World via POST!"
	end
	
	put '/' do
		"Hello World via PUT!"
	end
	
	delete '/' do
		"Goodbye World via DELETE!"
	end
	
	get "hello/:first_name/?:last_name" do |first,last|
		"Hello #{first} #{last}"
	end
	
end
