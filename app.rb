require "rubygems"

# Load Config
require "dotenv"
Dotenv.load

# Pry
require "pry"

# Web Framework
require "sinatra"
require "sinatra/reloader"

# O/R Mapper
require "data_mapper"
require "dm-mysql-adapter"

# Template
require "slim"

# Authentication
require "omniauth"
require "omniauth-oauth2"
require "omniauth-soundcloud"

# SoundCloud
require "soundcloud"

require "./auth"
require "./model"
require "./controller"
