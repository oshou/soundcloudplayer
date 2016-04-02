$:.unshift File.expand_path "vendor/bundle"

require "rubygems"
require "bundler/setup"

# Load Config
require "dotenv"
Dotenv.load

# Pry
require "pry"
require "pry-byebug"

# Web Framework
require "sinatra"
require "sinatra/reloader"

# Template
require "slim"

# Authentication
require "omniauth"
require "omniauth-oauth2"
require "omniauth-soundcloud"

# SoundCloud
require "soundcloud"

# Rspec
require "rspec"

require "./auth"
require "./controller"
