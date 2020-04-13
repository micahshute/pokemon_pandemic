class PokemonPandemic::Trainer


    attr_accessor :name, :gender, :team

    def initialize(name, gender)
        @name, @gender = name, gender
        @team = []
    end

end