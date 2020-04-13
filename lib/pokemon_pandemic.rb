require_relative "./pokemon_pandemic/version"
require 'httparty'
require "pry"
require_relative "./trainer"
require_relative "./strategies/start_game/start_strategy"
require_relative "./strategies/start_game/original_starters_start_strategy"
require_relative "./cli"
require_relative "./api_manager"
require_relative "./pokemon"


module PokemonPandemic
  class Error < StandardError; end
  # Your code goes here...


end
