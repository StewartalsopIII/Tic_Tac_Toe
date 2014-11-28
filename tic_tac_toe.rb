require 'pry'

#PC

#1. draw board
#2. ask the player to pick a square
#3. player picks a square (with x)
#4. computer picks a square (with 0)
#5. check to see if board is full or there is a winner
#6. repeat until soemone wins or the board is full 
#7. say what happens

def initialize_board
  b = {}
  (1..9).each {|position| b[position] = ' '}
  b
end

def draw_board(b)
  
  puts "#{b[1]}|#{b[2]}|#{b[3]} "
  puts "-----"
  puts "#{b[4]}|#{b[5]}|#{b[6]} "
  puts "-----"
  puts "#{b[7]}|#{b[8]}|#{b[9]} "
end

def empty_positions(b)
  b.select {|k, v| v == ' '}.keys
end

def player_choice(b)
  puts "Please pick a spot on the board: (1 - 9)"
  position = gets.chomp.to_i
  b[position] = 'X'
end

def computer_choice(b)
  position = empty_positions(b).sample
  b[position] = 'O'
end

def check_winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2, 5, 8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if b[line[0]] == 'X' and b[line[1]] == 'X' and b[line[2]] == 'X'
      return 'Player'
    elsif b[line[0]] == 'O' and b[line[1]] == 'O' and b[line[2]] == 'O'
      return 'Computer'
    else
      return nil
    end
  end
end


board = initialize_board
draw_board(board)

begin 
  player_choice(board)
  computer_choice(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner 
  puts "#{winner} won"
else
  puts "It's a tie"
end