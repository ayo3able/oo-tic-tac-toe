require 'pry'
class TicTacToe
    attr_accessor :board
    WIN_COMBINATIONS = [
        [0,1,2], # top row
        [3,4,5], # middle row
        [6,7,8], # bottom row
        [0,3,6], # left row
        [1,4,7], # middle vertical row
        [2,5,8], # right row
        [2,4,6], # right diagonal
        [0,4,8]  # left diagonal
        ]

    def initialize
       @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end 

      def input_to_index(input)
        input.to_i - 1
      end

      def move(input, player = "X")
        @board[input] = player
      end

      def position_taken?(input)
         @board[input] == "X" || @board[input] == "O"
      end

      def valid_move?(input)
        !position_taken?(input) && input.to_i.between?(0, 8)
      end
 
      def turn_count
      
        @board.count{|token|
            token == "X" || token == "O"}
      end

      def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end
     
      def turn
      
        index = input_to_index(gets.chomp)
          if valid_move?(index)
           move(index, current_player)
           display_board
          else
          turn
           end
      end

      def won?
        WIN_COMBINATIONS.find do |combo| 
         @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
        end
      end

      def full?
        @board.all? do |spot| 
        if spot == "X" || spot == "O"
          true
        else
          false
        end
        end 
      end

      def draw?
          full? && !won?
      end
      
      def over?
          won? || draw?
      end

      def winner
         if winning_combo = won?
          @winner = @board[winning_combo.first]
         end

      end

      def play
       until over?
        turn
       end
       if won?
        puts "Congratulations #{winner}!"
       else draw?
        puts "Cat's Game!"
       end
      end
      
end