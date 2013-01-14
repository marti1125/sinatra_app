require "sinatra/base"

class App < Sinatra::Base
	get '/' do
		"Hello World"
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
