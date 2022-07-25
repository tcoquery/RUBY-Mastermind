require "./colors"

class Computer 

  include Colors

  def initialize
    @code = ""
    @remaining_code = []
    @remaining_numbers = []
    @clues = []
    @computer_guess = [1, 1, 1, 1]
    @guesses = []
    @past_guesses = 0
    @turn = 1
    play
  end

  def play
    puts "\nEnter a four-digit number for the computer to guess"
    @user_code = gets.chomp
      if @user_code.match?(/^[1-6][1-6][1-6][1-6]$/)
        @code = @user_code.split("").map!(&:to_i)
        round
      else
        error
      end
  end

  def round
    check_correct_position(@computer_guess)
  end

  def check_correct_position(guess)
    @clues.clear
    @remaining_numbers.clear
    @remaining_code.clear
    combined_combinations = @code.zip(guess)
    
    combined_combinations.each_with_index do |array, index| 
      if array[0]==array[1]
        @clues.push("\u25CB")
      else
        @remaining_numbers.push(guess[index])
        @remaining_code.push(@code[index])
      end
    end
    check_wrong_position
    check_game_over(guess)
  end

  def check_wrong_position
    @remaining_numbers.each do |number|
      count = @remaining_code.count(number)
      count.times do
        @clues.push("\u25CF")
        @remaining_code.delete(number)
      end
    end
  end

  def check_game_over(guess)
    puts "\nTurn ##{@turn} :"
    show_code(guess)
    puts @clues.join
    @turn += 1
    if @turn == 13
      puts "\nCongratulations, the computer lost, Sarah Connor will sleep peacefully tonight."
    elsif @clues.join == "\u25CB\u25CB\u25CB\u25CB"
      puts "\nSorry, the computer beat you, it's time to join the resistance."
    else
      next_computer_guess(guess)
    end
  end

  def next_computer_guess(guess)
    if @clues.empty? # If there are no clues, that means no number is present in the user's code
      @computer_guess.map! {|elem| elem+1}
      check_correct_position(@computer_guess)  
    elsif @clues.count == 4 # All 4 numbers have been guessed but not necessarily in the right position
      @guesses.push(guess)
      check_past_guesses(guess)
    else
      check_clues
    end
  end

  def check_clues
    clue_count = @clues.count {|elem| elem == "\u25CB" || elem == "\u25CF"}

    i = clue_count 
    while i < 4 do
      unless @computer_guess[i] == 6
        @computer_guess[i] += 1
        i += 1
      end
    end
    check_correct_position(@computer_guess)
  end

  def check_past_guesses(guess)
    @past_guesses = 0
    @guesses.each do |arr| 
      if arr.eql?(guess)
        @past_guesses += 1
      end
    end
    if @past_guesses > 0
      check_correct_position(@computer_guess.shuffle)
    else 
      check_correct_position(guess)
    end
  end

  def error
    puts "Erroneous input! Try again..."
    play
  end
end