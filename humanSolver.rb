class Human

  def initialize
    @colors = ["1", "2", "3", "4", "5", "6"].shuffle
    @remaining_combination = []
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

  def check_correct_position(user_guess)
    @combined_combinations = @colors[0..3].zip(user_guess)
      @combined_combinations.each_with_index do |array, index| 
      if array[0]==array[1]
        @clues.push("\u25CB")
      else
        @remaining_numbers = @remaining_numbers.push(user_guess[index])
        @remaining_combination = @remaining_combination.push(@colors[index])
      end
    end
  end

  def check_wrong_position
    @remaining_numbers.each do |number|
      if @remaining_combination.include?(number)
        @clues.push("\u25CF")
        @remaining_combination.delete(number)
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
      @remaining_combination.clear
      @turn +=1 
      
    end
  end

  def error
    puts "Erroneous input! Try again..."
    round
  end
end