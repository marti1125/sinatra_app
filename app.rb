require "sinatra/base"

IMAGES = [
	{title: "gunbound", url:"/images/0.jpg"},
	{title: "navyfield", url:"/images/1.jpg"},
	{title: "hon", url:"/images/2.jpg"},
]

class App < Sinatra::Base

	enable :sessions
	disable :show_exepctions
	register Sinatra::Prawn

	before /images/ do
		@message = "You're viewing an image."
	end
	
	configure do
		# set: environmenet, ENV["RACK_ENV"]
		# :environment
		# :logging
		# :method_override
		# set :public_folder, "assets"
		# :raise_errors
		# :root
		# :sessions
		# :show_exepctions
		# :static
		# :views
		# set :views, "templates"
		set({ foo: "bar", baz: "foo"})
	end

	not_found do
		haml :"404", layout: true, layout_engine: :erb
	end

	error do
		haml :error, layout: true, layout_engine: :erb
	end

	error 403 do
		haml :"403", layout: true, layout_engine: :erb
	end

	get "/500" do
		raise StandardError, "Intentional blowing up"
	end

	configure :development do
	end

	configure :production do
	end

	before do
		@user = "Willy Aguirre"
		@height = session[:height]
		@environment = settings.environment
		#@request = request
		logger = Log4r::Logger["app"]
		logger.info "==> Entering request"
		logger.debug settings.foo
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

	get "/sample.pdf" do
		attachment
		content_type :pdf
		@message = "Hello from the PDF!"
		prawn :samplepdf
	end
	
	get '/images' do
		halt 403 if session[:height].nil?
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
