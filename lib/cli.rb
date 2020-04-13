class PokemonPandemic::CLI

    def initialize(start_strategy: PokemonPandemic::OriginalStartersStartStrategy)
        @necessary_tasks = []
        @necessary_tasks << Thread.new do 
            get_pokemon_data
            @start_strategy = start_strategy.new
        end
        @trainer = nil
        @page = 1
        @limit = 807
    end


    def start
        introduction
        @necessary_tasks.each{ |thr| thr.join }
        @trainer = @start_strategy.starting_sequence
        binding.pry
    end

    def get_pokemon_data
        PokemonPandemic::APIManager.get_pokemon(@page, @limit)
    end


    def introduction
        puts "\n\n\n\n\n\n"
        puts "Welcome to the Wonderful World of Pokemon!"
        puts "\n\n\n\n\n\n"
        sleep(3)
        puts "...calibrating the world..." 
        puts "\n\n\n"
    end

 

    def get_page_range
        [(@page - 1) * @limit, @page * @limit]
    end



end