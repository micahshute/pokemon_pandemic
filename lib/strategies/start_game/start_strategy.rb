class PokemonPandemic::StartStrategy

    attr_accessor :first_interaction_person, :starting_pokemon, :player_data
     
    def initialize(first_interaction_person: , starting_pokemon: )
        @first_interaction_person, @starting_pokemon = first_interaction_person, starting_pokemon
        @player = nil
    end

    def starting_sequence
        intro
        @player = get_player_info
        @starter = choose_starter
        closing_comments
        @player.team << @starter
        @player
    end

    def closing_comments
        raise Error.new("Subclasses of StartStrategy must implement their own starting_sequence method")
    end

    def choose_starter
        raise Error.new("Subclasses of StartStrategy must implement their own starting_sequence method")
    end

    def intro
        raise Error.new("Subclasses of StartStrategy must implement their own starting_sequence method")
    end

    def get_player_info 
        raise Error.new("Subclasses of StartStrategy must implement their own starting_sequence method")
    end

    def ddd_sleep
        sleep(1)
        puts "..."
        sleep(1)
        puts "..."
        sleep(1)
    end

    

end