class Human

  def initialize
    @colors = ["1", "2", "3", "4", "5", "6"].shuffle
    @remaining_code = []
    @remaining_numbers = []
    @clues = []
    @game_over = false
    @turn = 0
    play
  end
  

  def play
    check_endgame
    if @game_over
      return
    else
    round
    end
  end

  def round
    puts "\nTurn ##{@turn} : please enter a four-digit number to make your guess"
    @user_guess = gets.chomp
      if @user_guess.match?(/^[1-6][1-6][1-6][1-6]$/)
        check_correct_position(@user_guess.split(""))
        check_wrong_position
        play
      else
        error
      end
  end

  # This method combines the code and the user guess in @combined_combinations.
  # If the user guessed the right position then @combined_combinations will have
  # something like [[2, 2]].
  # For the remaining numbers, they are pushed into different arrays, @remaining_numbers
  # and @remaining_code. If a number in @remaining_numbers is included in @remaining_code
  # then that means, the user guessed a correct number but in the wrong position. 

  def check_correct_position(user_guess)
    @combined_combinations = @colors[0..3].zip(user_guess)
      @combined_combinations.each_with_index do |array, index| 
      if array[0]==array[1]
        @clues.push("\u25CB")
      else
        @remaining_numbers = @remaining_numbers.push(user_guess[index])
        @remaining_code = @remaining_code.push(@colors[index])
      end
    end
  end

  def check_wrong_position
    @remaining_numbers.each do |number|
      if @remaining_code.include?(number)
        @clues.push("\u25CF")
        @remaining_code.delete(number)
      end
    end
    puts @clues.join
  end

  def check_endgame
    if @clues.join == "\u25CB\u25CB\u25CB\u25CB"
      @game_over = true
      puts "Congratulations, you won !"
    elsif @turn > 11
      @game_over = true
      puts "You lost. The correct combination was #{@colors[0..3].join}."
    else
      @clues.clear
      @remaining_numbers.clear
      @remaining_code.clear
      @turn +=1 
    end
  end

  def error
    puts "Erroneous input! Try again..."
    round
  end
end