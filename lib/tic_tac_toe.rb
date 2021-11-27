require 'pry'
class TicTacToe

    attr_accessor :board

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n ----------- \n #{@board[3]} | #{@board[4]} | #{@board[5]} \n ----------- \n #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        return (input.to_i) -1
    end

    def move (index, token = 'X')
        self.board[index] = token
    end

    def position_taken? (index)
        return @board[index] == " " ? false : true
    end

    def valid_move? (index)
        return true if index >= 0 && index <= 8 && self.position_taken?(index) == false
    end

    def turn_count
        count = 0
        @board.each do |position|
            if position != ' '
                count += 1
            end
        end
        count
    end

    def current_player
        case true
        when self.turn_count == 0
            then return 'X'
        when self.turn_count%2 != 0
            then return 'O'
        when self.turn_count%2 == 0
            then return 'X'
        end
    end

    def turn
        puts "Enter a position between 1 and 9"
        input = gets
        move_index = self.input_to_index(input)
        if self.valid_move?(move_index) == true
            token = self.current_player
            self.move(move_index, token)
            self.display_board
        else
            self.turn
        end
    end

    def won?
        x_indexes = []
        o_indexes = []
        @board.each.with_index do |pos, index|
            if pos != ' '
                if pos == 'X'
                    x_indexes << index
                elsif pos == 'O'
                    o_indexes << index
                end
            end
        end
        WIN_COMBINATIONS.each do |combination|
            if (combination - x_indexes).empty? == true
                return combination
            elsif (combination - o_indexes).empty? == true
                return combination
            end
        end
        return false
    end

    def full?
        if self.turn_count == 9
            return true
        else
            return false
        end
    end

    def draw?
        return true if self.full? == true && self.won? == false
    end

    def over?
        if self.draw? == true || self.won? != false
            return true
        else
            return false
        end
    end

    def winner
        result = self.won?
        if result != false
            return @board[result[0]]
        else
            return nil
        end
    end

    def play
        until self.over? == true
            self.turn
        end

        if self.winner != nil
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
    end
end