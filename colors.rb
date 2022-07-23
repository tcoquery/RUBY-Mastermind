module Colors
  def code_colors(number)
    {
      1 => "\e[41m  1  \e[0m ",
      2 => "\e[42m  2  \e[0m ",
      3 => "\e[43m  3  \e[0m ",
      4 => "\e[44m  4  \e[0m ",
      5 => "\e[45m  5  \e[0m ",
      6 => "\e[46m  6  \e[0m ",
    }[number]
  end

  def show_code(array)
    array.each do |num|
      print code_colors num
    end
  end
end