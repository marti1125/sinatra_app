require "rubygems"
Bundler.require
require "./app"
require "./db"

logger = Log4r::Logger.new "app"
logger.outputters << Log4r::Outputter.stderr
file = Log4r::FileOutputter.new('app-file', :filename => 'log/app.log')
file.formatter = Log4r::PatternFormatter.new(:pattern => "[%1] %d :: %m")
logger.outputters << file

run App
