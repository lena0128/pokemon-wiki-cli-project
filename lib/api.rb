require 'pry'
require 'httparty'
require 'json'
require 'colorize'

require_relative 'pokemon.rb'

class Api
    attr_accessor :query

    def initialize(query)
      @query = query
    end

    def fetch_pokemon
      url = "https://pokeapi.co/api/v2/pokemon/#{query}/"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      pokemon_array = []
      pokemon_array << {
      :name => json["name"],      
      :height => json["height"],
      :weight => json["weight"],
      :id => json["id"],
      :order => json["order"],
      :moves => (json["moves"].collect {|move| move["move"]["name"]})[1..10],
      :abilities => json["abilities"].collect {|ability| ability["ability"]["name"]},
      :base_experience => json["base_experience"],
      :forms => json["forms"].collect {|form| form["name"]},
      :held_items => json["held_items"].collect {|item| item["item"]["name"]},
      :location_area_encounters => json["location_area_encounters"]
      }
    end

    def create_pokemon
      self.fetch_pokemon.each do |hash|
       Pokemon.new(hash)
      end
    end

  
  end