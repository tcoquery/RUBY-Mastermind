require "./colors"
require "./humanSolver"
require "./computerSolver"

class Game 

  include Colors

  def initialize
    banner
    rules
    play
  end

  def banner
    puts "========================="
    puts "=======MASTERMIND========"
    puts "=========================\n\n"
  end

  def rules
    puts "The objective is to find the correct color and order combination in 12 rounds or less."
    puts "\nThere are six colors :" 
    show_code([1,2,3,4,5,6])
    puts "\n\nThe combination is made up of four colors, each color can be present more \nthan once."
    puts "\nEach round, you get clues:" 
    puts "\u25CF If you found a color but in the wrong position." 
    puts "\u25CB If you found a color in the right position."
  end

  def play
    modeSelection
  end

  def modeSelection
    puts "\nPlease choose if you want to solve the code (1) or try to beat the computer (2)"
    @user_choice = gets.chomp
    if @user_choice.match?(/^[1-2]$/)
      gameMode(@user_choice)
    else error
    end
  end

  def gameMode(num)
    Human.new if num == "1" 
    Computer.new if num == "2" 
  end

  def error
    puts "Erroneous input! Try again..."
    modeSelection
  end
end

Game.new