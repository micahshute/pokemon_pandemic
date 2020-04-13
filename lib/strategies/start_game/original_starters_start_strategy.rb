class PokemonPandemic::OriginalStartersStartStrategy < PokemonPandemic::StartStrategy

    def initialize
        starting_pokemon = [PokemonPandemic::Pokemon.all[0], PokemonPandemic::Pokemon.all[3], PokemonPandemic::Pokemon.all[6]]
        super(starting_pokemon: starting_pokemon, first_interaction_person: "Professor Oak")
    end

    def intro
        puts "Hello my child! My name is #{@first_interacting_person}, and I want to give you a grand gift!"
        ddd_sleep
    end

    def get_player_info 
        puts "Let's get some info about you!"
        name = get_name
        gender = get_gender
        PokemonPandemic::Trainer.new(name, gender)
    end

    def valid_response?(gen)
        valid_responses = ["boy", "girl", "other"]
        valid_responses.include?(gen)
    end

    def get_gender
        puts "And are you a boy or a girl?"
        gen = gets.strip.downcase
        get_gender if !valid_response?(gen)
    end

    def get_name
        puts "First of all, what is your name?"
        gets.strip
    end
    
    def choose_starter
        ddd_sleep
        puts "Now, time to pick your closest friend and truest companion!"
        introduce_options_and_make_selection
    end

    def introduce_options_and_make_selection
        puts "Here are your options!"
        puts "Pay close attention! This is a big decision!"
        # @starting_pokemon.each{ |p| PokemonPandemic::APIManager.get_more_pokemon_info(p)}
        choice_loop
    end

    def display_single_pokemon(i)
        p = @starting_pokemon[i]
        PokemonPandemic::APIManager.get_more_pokemon_info(p) if !p.full?
        puts p.full_details
        puts 'Type "y" to confirm choice. Press any other key to view another'
        input = gets.strip.downcase
        if input.include?("y")
            p
        else
            nil
        end
    end

    def get_pokemon_choice
        commands = ["exit"]
        input = gets.strip.downcase
        return input.downcase if commands.include?(input.downcase)
        if !valid?(input)
            puts "umm... that doesn't make sense"
            return "invalid"
        end
        return input.to_i - 1
    end

    def choice_loop
        loop do
            menu
            input = get_pokemon_choice
            case input
            when "exit"
                exit
            else
                chosen = display_single_pokemon(input)
            end
            return chosen if chosen
        end
    end


    def valid?(i)
        i.to_i.between?(1, @starting_pokemon.length)
    end

    def menu
        display_pokemon
        display_instructions
    end
    
    
    def closing_comments
        puts "Off to the wild blue yonder now, lad! Talley Ho!"
    end

    def display_pokemon
        @starting_pokemon.each.with_index do |p, i|
            puts "#{i+1}) #{p}"
        end
    end


    def display_instructions
        puts <<-INST

Please choose a pokemon by number to view it!

        INST
    end


end