

class PokemonPandemic::APIManager

    BASE_URL = "https://pokeapi.co/api/v2/"

    def self.get_pokemon
        url = BASE_URL + "pokemon"
        res = HTTParty.get(url)
        PokemonPandemic::Pokemon.mass_create_from_api(res["results"])
    end

end