

class PokemonPandemic::Pokemon

    @@all = []

    def self.all
        @@all
    end

    def self.mass_create_from_api(pokearr)
        pokearr.each do |pokehash|
            new(pokehash["name"], pokehash["url"])
        end
    end

    attr_accessor :url, :description, :height, :weight, :id
    attr_writer :name, :types

    def initialize(name, url)
        @name, @url = name, url
        @description, @height, @weight, @id = nil, nil, nil, nil
        @types = []
        save
    end

    def to_s
        self.name
    end

    def name
        @name.capitalize
    end

    def types
        @types.map(&:capitalize)
    end 

    def save
        @@all << self
    end

    def full?
        !!@description
    end

    def populate_data(height: , weight: , description: , types:, id:)
        self.height = height
        self.weight = weight
        self.description = description
        self.types = types
        self.id = id
    end

    def full_details
        <<-DESC


POKEMON ID: #{id}  NAME: #{name}
Height: #{height}    Weight: #{weight}

#{types.length > 1 ? "Types": "Type"}: #{types.join(", ")}

#{description}


        DESC
        
    end

end