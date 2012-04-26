# Project Euler problem 84
# Monopoly
#
# Strategy -
# Monte Carlo simulation
# 1. Start 10,000 robots on GO.
# 2. Take 1,000 turns, following all the rules of Monopoly.
# 3. Count where the robots are.
# 4. Output the 6 character string that denotes the 3 most populous squares.

SQUARE_NAMES = %w[ GO A1 CC1 A2 T1 R1 B1 CH1 B2 B3 JAIL C1 U1 C2 C3 R2 D1 CC2 D2 D3 FP E1 CH2 E2 E3 R3 F1 F2 U2 F3 G2J G1 G2 CC3 G3 R4 CH3 H1 T2 H2 ]

class Robot
  def initialize
    @consecutive_doubles_count = 0
    @last_double = nil
  end

  # A robot needs to:
  #   roll dice
  #   know when
  def dice_roll
    roll1 = rand(4) + 1
    roll2 = rand(4) + 1
    if roll1 == roll2
      if roll1 + roll2 == @last_double
        @consecutive_doubles_count += 1
      else
        @consecutive_doubles_count = 1
        @last_double = roll1 + roll2
      end
    end
    roll1 + roll2
  end

  def rolled_three_consecutive_doubles?
    @consecutive_doubles_count == 3
  end

  def reset_consecutive_doubles_count
    @consecutive_doubles_count = 0
  end
end

class Board
  # A board needs to:
  #   know what the squares are
  #   move the robot around appropriately according to the robot's roll
  #   move the robot according to the rules of the game
  #   know where the robots are on the board
  def initialize(robots)
    @squares = initialize_squares
    robots.each do |robot|
      get_go.add_robot(robot) # put all robots on GO
    end
  end

  def perform_turn
    @squares.each do |square|
      robots = square.pop_robots
      robots.each do |robot|
        roll = robot.dice_roll
        if robot.rolled_three_consecutive_doubles?
          robot.reset_consecutive_doubles_count
          get_jail.add_robot(robot)
        else
          dest_square = calculate_dest_square(square, roll)
          dest_square.add_robot(robot)
        end
      end
    end
  end

  def top_three_squares_string
    @squares.sort_by! do |square|
      square.num_visits
    end
    @squares.pop.idx_str + @squares.pop.idx_str + @squares.pop.idx_str
  end

  private

  def initialize_squares
    squares = []
    0.upto(SQUARE_NAMES.size - 1) do |idx|
      squares << Square.new(idx)
    end
    squares
  end


  def calculate_dest_square(curr_square, roll)
    # puts "curr_square.idx = #{curr_square.idx}"
    # puts "roll = #{roll}"
    # puts "(curr_square.idx + roll) % @squares.size = #{(curr_square.idx + roll) % @squares.size}"
    # puts ""
    next_square = @squares[(curr_square.idx + roll) % @squares.size]
    dest_square = next_square
    if next_square.is_community_chest? or next_square.is_chance?
      card = next_square.get_next_card
      if card.size > 4 and card[0,4] == 'next' # next railway or utility
        r_or_u = card[-1] # the last letter says whether to find railway or utility
        dest_square = get_next_railway_or_utility(next_square, r_or_u)
      elsif card == "back 3 squares" # back 3 squares
        # Since we may land on a community chest, chance, or go to jail when
        # we move back 3 squares, we'll recursively call
        dest_square = calculate_dest_square(next_square, -3)
      elsif card.size > 0 # move to GO, JAIL, C1, E3, H2, or R1
        dest_square = get_square_with_name(card)
      else
        dest_square = next_square # We drew a non-movement card, stay put
      end
    elsif next_square.is_go_to_jail?
      dest_square = get_jail
    end
    dest_square
  end

  def get_jail
    @squares[10]
  end

  def get_go
    @squares[0]
  end

  def get_square_with_name(name)
    @squares.each do |square|
      return square if square.name == name
    end
    nil
  end

  def get_next_railway_or_utility(after_this_square, r_or_u)
    curr = after_this_square
    while curr.name[0,1] != r_or_u
      curr = @squares[(curr.idx + 1) % @squares.size]
    end
    curr
  end
end

class Square
  def initialize(idx)
    @idx = idx
    @robots = []
    @cards = initialize_cards # Community Chest and Chance will have cards
    @num_visits = 0
  end

  def add_robot(robot)
    @robots << robot
    @num_visits += 1
  end

  def pop_robots
    popped_robots = []
    @robots.size.times do
      popped_robots << @robots.pop
    end
    popped_robots
  end

  def num_robots
    @robots.size
  end

  def num_visits
    @num_visits
  end

  def name
    SQUARE_NAMES[@idx]
  end

  def idx
    @idx
  end

  def idx_str
    idx_str = @idx.to_s
    if idx_str.size < 2
      idx_str = "0" + idx_str
    end
    idx_str
  end

  def print
    puts "#{@idx} #{name} => #{@robots.size} robots"
  end

  def is_community_chest?
    name[0,2] == 'CC'
  end

  def is_chance?
    name[0,2] == 'CH'
  end

  def is_go_to_jail?
    name == "G2J"
  end

  def get_next_card
    card = @cards.pop
    @cards.unshift card
    card
  end

  private

  def initialize_cards
    cards = []
    if self.is_community_chest?
      14.times do
        cards << "" # 14 of the cards in Community Chest do NO movement
      end
      cards << "JAIL" # Go to JAIL
      cards << "GO" # Go to GO
    elsif self.is_chance?
      6.times do
        cards << "" # 6 of the cards in Chance do NO movement
      end
      cards << "GO"
      cards << "JAIL"
      cards << "C1"
      cards << "E3"
      cards << "H2"
      cards << "R1"
      cards << "next R" # Go to next R (railway company)
      cards << "next R"
      cards << "next U" # Go to next U (utility company)
      cards << "back 3 squares"
    end
    cards.shuffle!
  end
end

def create_robots(n_robots)
  robots = []
  n_robots.times do
    robots << Robot.new
  end
  robots
end

def main
  robots = [Robot.new]
  board = Board.new(robots)
  1.upto(10000) do |turn_number|
    if turn_number % 100 == 0
      puts "Computing turn #{turn_number}"
    end
    board.perform_turn
  end
  puts "String repr. of three most visited squares:"
  puts board.top_three_squares_string
end

main
