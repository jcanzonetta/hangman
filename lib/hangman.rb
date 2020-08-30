txt = File.open("5desk.txt")

dict = txt.readlines.map(&:chomp)
dict_size = dict.length


class Game

    def initialize
        @dict = get_dict
        @game_word = get_game_word()
        @displayed_word = Array.new(@game_word.length, "_")
        @turns = 6
        @game_over = false

        game_loop()
        
    end

    def game_loop
        while @game_over == false
            letter = get_letter()
            check_letter(letter)

            render_word_canvas()

        end
    end

    def get_letter
        print "What letter do you want to guess? "
        return gets.chomp.downcase
    end

    def check_letter(letter)
        @game_word.each_with_index do |game_letter, index|
            if game_letter == letter
                @displayed_word[index] = letter
            end
        end
    end

    def render_word_canvas
        puts "The current word is:"
        @displayed_word.each do |character|
            print "#{character} "
        end
        puts nil
    end

    def get_dict
        txt = File.open("5desk.txt")
        return txt.readlines.map(&:chomp)
    end

    def get_game_word
        word = @dict[rand(@dict.length)]

        while word.length < 5 || word.length > 12 do
            word = @dict[rand(@dict.length)]
        end
        puts "The selected word is #{word}."
        return word.split("")
    end
end

game1 = Game.new