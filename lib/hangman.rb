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
        @used_letters = []

        game_loop()
    end

    def game_loop
        render_word_canvas()

        while @game_over == false
            letter = get_letter()
            store_letter(letter)
            check_letter(letter)
            render_used_letters()
            render_word_canvas()

            @game_over = determine_out_of_turns() || determine_win() ? true : false

        end

        puts "Game Over\n\n"
    end

    def store_letter(letter)
        if !@used_letters.include?(letter)
            @used_letters.push(letter)
        end
    end

    def render_used_letters
        puts "You've already used the following letters:"
        @used_letters.each do |letter|
            print "#{letter}, "
        end
        puts "\n\n"
    end

    def determine_out_of_turns
        if @turns < 1
            puts "You're out of turns! The correct word was #{@game_word.join("")}."
            return true
        else
            return false
        end
    end
    
    def determine_win
        if @displayed_word.include?("_")
            return false
        else
            puts "You win!"
            return true
        end
    end

    def get_letter
        print "What letter do you want to guess? "
        return gets.chomp.downcase
    end

    def check_letter(letter)
        success = false
        @game_word.each_with_index do |game_letter, index|
            if game_letter == letter
                @displayed_word[index] = letter
                success = true
            end
        end

        if success == false
            decrement_turns()
        end
    end

    def decrement_turns
        @turns -= 1
        puts "\nIncorrect! You have #{@turns} turns remaining.\n"
    end

    def render_word_canvas
        puts "The current word is:"
        @displayed_word.each do |character|
            print "#{character} "
        end
        puts "\n\n"
    end

    def get_dict
        txt = File.open("5desk.txt")
        return txt.readlines.map(&:chomp)
    end

    def get_game_word
        word = @dict[rand(@dict.length)]

        while word.length < 5 || word.length > 12 do
            word = @dict[rand(@dict.length)].downcase
        end

        return word.split("")
    end
end

game1 = Game.new