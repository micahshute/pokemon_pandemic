

class PokemonPandemic::APIManager

    BASE_URL = "https://pokeapi.co/api/v2/"

    def self.get_pokemon(pagenum=1, limit=20)

        puts "\nMAKING A NETWORK REQUEST........\n"


        #MAKE CHANGES

        url = BASE_URL + "pokemon?offset=#{(pagenum -1)*limit}&limit=#{limit}"
        res = HTTParty.get(url)
        PokemonPandemic::Pokemon.mass_create_from_api(res["results"])
        return {
            next: res["next"],
            prev: res["previous"]
        }
    end

    def self.get_more_pokemon_info(pokemon)
        puts "\nMAKING A NETWORK REQUEST........\n"

        url = pokemon.url
        res = HTTParty.get(url)
        weight = res["weight"]
        height = res["height"]
        id = res["id"]
        types = res["types"].map{|h| h["type"]["name"]}
        des_url = res["species"]["url"]

        sres = HTTParty.get(des_url)
        ftentries = sres["flavor_text_entries"].find do |h|
            h["language"]["name"] == "en"
        end
        description = ftentries && ftentries["flavor_text"]
        pokemon.populate_data(weight: weight, height: height, description: description, types: types, id: id)
    end

end