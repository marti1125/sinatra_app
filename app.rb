require "sinatra/base"

IMAGES = [
	{title: "gunbound", url:"/images/0.jpg"},
	{title: "navyfield", url:"/images/1.jpg"},
	{title: "hon", url:"/images/2.jpg"},
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

	get '/images/:index/download' do |index|
		@image = IMAGES[index.to_i]
		attachment @image[:title]
		send_file "images/#{index}.jpg"
	end
	
	get '/images/:index.?:format?' do |index, format|
		index = index.to_i
		@image = IMAGES[index]
		@index = index
		
		if format == "jpg"
			content_type :jpg #image/jpg
			send_file "images/#{index}.jpg"
		else
			haml :"images/show", layout: true
		end
		
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
