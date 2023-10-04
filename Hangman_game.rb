class Hangman

    def initialize
      @word = words.sample
      @lives = 7
      @hidden_word = ""
  
      @word.first.size.times do
        @hidden_word += "_ "
      end
    end
  
    def words
      [
        ['football', 'A game played with a ball and legs'],
        ['cricket', 'A game played with a bat and ball'],
        ['water', 'Something everyone drinks'],
        ['shoes', 'Something everyone wears on their feet'],
        ['cup', 'We drink coffee from it']
      ]
    end
  
    def display_hidden_word(last_guess = nil)
      update_hidden_word(last_guess) unless last_guess.nil?
      puts @hidden_word
    end
  
    def update_hidden_word(last_guess)
      new_hidden_word = @hidden_word.split
  
      new_hidden_word.each_with_index do |letter, index|
        if letter == '_' && @word.first[index] == last_guess
          new_hidden_word[index] = last_guess
        end
      end
  
      @hidden_word = new_hidden_word.join(' ')
    end
  
    def make_guess
      if @lives > 0
        puts "Guess a letter"
        guess = gets.chomp
  
        good_guess = @word.first.include?(guess)
  
        if guess == "exit"
          puts "Thanks for playing!"
        elsif guess.length > 1
          puts "Please guess only one letter at a time!"
          make_guess
        elsif good_guess
          puts "Correct guess!"
          display_hidden_word(guess)
  
          if @word.first == @hidden_word.split.join
            puts "Congratulations, you won this round!"
          else
            make_guess
          end
        else
          @lives -= 1
          puts "Sorry, you have #{@lives} lives left. Try again!"
          make_guess
        end
      else
        puts "Game over. The word was #{@word.first}. Better luck next time!"
      end
    end
  
    def start_game
      puts "Welcome to Hangman! Your word has #{ @word.first.size } characters."
      puts "To exit the game at any point, type 'exit'."
      display_hidden_word
  
      puts "Clue: #{ @word.last }"
  
      make_guess
    end
  
  end
  
  game = Hangman.new
  game.start_game
  