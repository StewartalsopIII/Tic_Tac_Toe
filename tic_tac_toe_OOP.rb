class Player
  attr_accessor :choice
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def pick_hand
    begin
      puts "\nEnter \'r\' for rock, \'p\' for paper, or \'s\' for scissors: "
      puts 
      self.choice = gets.chomp.downcase
    end until Game::OPTIONS.keys.include?(choice)
  end
end

class Computer < Player 
  def pick_hand
    self.choice = Game::OPTIONS.keys.sample 
  end
end

class Game 
  OPTIONS = {'r' => 'rock', 's' => 'scissors', 'p' => 'paper'}

  attr_reader :player, :computer

  def initialize 
    @player = Human.new('You')
    @computer = Computer.new('The computer')
  end

  def intro
    system 'clear'
    puts "Welcome to Rock-Paper-Scissors"
    puts "Rock smashes Scissors, Paper wraps Rock, and Scissors cuts Paper"
  end

  def message(winning_hand)
    case winning_hand
    when 'r'
      puts "\nRock breaks scissors!"
    when 'p'
      puts "\nPaper wraps rock!"
    when 's'
      puts "\nScissors cuts paper!"
    end
  end

  def compare
    if player.choice == computer.choice
      puts "You both chose the same thing!"
      puts "Its a tie"
    elsif (player.choice == 'r' && computer.choice == 's') ||
          (player.choice == 'p' && computer.choice == 'r') ||
          (player.choice == 's' && computer.choice == 'p')
      puts "\nYou chose #{OPTIONS[(player.choice)]} and the"\
           " computer chose #{OPTIONS[(computer.choice)]}."
      message(player.choice)
      puts "\nYou won!"
    else
      puts "\nYou chose #{OPTIONS[(player.choice)]} and the" \
           " computer chose #{OPTIONS[(computer.choice)]}"
      message(computer.choice)
      puts "\nThe Computer won!"
    end
  end

  def replay
    play_again_choice = 'n'

    while play_again_choice != 'y'
      puts "\nWould you like to play again? (Y/N)"
      puts

      play_again_choice = gets.chomp.downcase

      unless %w(y n).include?(play_again_choice)
        puts "\nError. Invalid entry. Please enter 'y' or 'n'."
        next
      end

      if play_again_choice == 'y'
        Game.new.play
      elsif play_again_choice == 'n'
        puts "\nThanks for playing!"
        exit
      end
    end
  end
        

  def play
    intro
    player.pick_hand
    computer.pick_hand
    compare
    replay
  end
end

Game.new.play