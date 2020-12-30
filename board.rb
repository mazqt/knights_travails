require 'byebug'

class Board

  attr_reader :moves
  def initialize
    @board = create_board()
    @moves = possible_moves()
  end

  def create_board
    board = []

    8.times do |row|
      8.times do |column|
        board << [row, column]
      end
    end

    board
  end

  def possible_moves
    all_moves = {}

    @board.each do |position|
      moves = []
      moves << [(position[0] - 1), (position[1] - 2)]
      moves << [(position[0] + 1), (position[1] - 2)]
      moves << [(position[0] + 2), (position[1] - 1)]
      moves << [(position[0] + 2), (position[1]) + 1]
      moves << [(position[0] + 1), (position[1] + 2)]
      moves << [(position[0] - 1), (position[1] + 2)]
      moves << [(position[0] - 2), (position[1] + 1)]
      moves << [(position[0] - 2), (position[1] - 1)]
      moves.reject! { |move| move[0] > 7 || move[0] < 0 || move[1] > 7 || move[1] < 0}
      all_moves[position] = moves
    end

    all_moves
  end

  def knight_moves(start, goal)
    queue = [start, [start]]

    debugger

    loop do
      legal_moves = @moves[queue.shift]
      current_chain = queue.shift

      legal_moves.each do |move|
        next_chain = []
        current_chain.each { |step| next_chain << step }
        next_chain << move
        if move == goal
          puts "You made it in #{next_chain.length - 1} moves! Here's your path :"
          next_chain.each { |move| p move }
          return
        end
        queue << move
        queue << next_chain
      end
    end
  end
end
