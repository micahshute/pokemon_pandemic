


class PokemonPandemic::CLI

    def initialize
        @page = 1
        @limit = 20
    end


    def start
        introduction
        get_pokemon_data
        game_loop
    end

    def get_pokemon_data
        PokemonPandemic::APIManager.get_pokemon(@page, @limit)
    end


    def game_loop
        loop do
            menu
            input = get_pokemon_choice
            case input
            when "exit"
                break
            when "invalid"
                next
            when "next"
                @page += 1
                _, stop = get_page_range
                if PokemonPandemic::Pokemon.all.length < stop
                    get_pokemon_data
                end
            when "prev"
                if @page <= 1 
                    puts "You cannot get that page, you are alredy on page 1!"
                else
                    @page -= 1
                end
            else
                display_single_pokemon(input)
            end
       
        end
    end

    def display_single_pokemon(i)
        p = PokemonPandemic::Pokemon.all[i]
        PokemonPandemic::APIManager.get_more_pokemon_info(p) if !p.full?
        puts p.full_details
        puts 'press any key to continue:'
        gets
    end

    def get_pokemon_choice
        commands = ["exit", "next", "prev"]
        input = gets.strip.downcase
        return input.downcase if commands.include?(input.downcase)
        if !valid?(input)
            puts "umm... that doesn't make sense"
            return "invalid"
        end
        return input.to_i - 1
    end

    def valid?(i)
        i.to_i.between?(1, PokemonPandemic::Pokemon.all.length)
    end

    def menu
        display_pokemon
        display_instructions
    end


    def introduction
        puts "\n\n\n\n\n\n"
        puts "Welcome to the Wonderful World of Pokemon!"
        sleep(2)
        puts "\n\n\n\n\n\n"
    end

    def display_pokemon
        start, stop = get_page_range
        puts "\n\nPAGE #{@page}"
        PokemonPandemic::Pokemon.all[start...stop].each.with_index(start) do |p, i|
            puts "#{i+1}) #{p}"
        end
    end

    def get_page_range
        [(@page - 1) * @limit, @page * @limit]
    end


    def display_instructions
        puts <<-INST


Please choose a pokemon by number or type 'exit' to exit the program

You may also type 'next' to see the next page of pokemon #{@page > 1 ? "or 'prev' to see the previous page of pokemon" : "" }
        INST
    end

end