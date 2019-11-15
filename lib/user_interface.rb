# frozen_string_literal: true

# methoods to help interact with the user
module UserInterface
  private

  TROPHY = ["                                  ___________\n",
            "                             .---'::'        `---.\n",
            "                            (::::::'              )\n",
            "                            |`-----._______.-----'|\n",
            "                            |              :::::::|\n",
            "                           .|               ::::::!-.\n",
            "                           \\|               :::::/|/\n",
            "                            |               ::::::|\n",
            "                            |                    :|\n",
            "                            |                 ::::|\n",
            "                            |               ::::::|\n",
            "                            |              .::::::|\n",
            "                            J              :::::::F\n",
            "                             \\            :::::::/\n",
            "                              `.        .:::::::'\n",
            "                                `-._  .::::::-'\n",
            '____________________________________|  """|"___________________',
            "_______________\n",
            "                                    |  :::|\n",
            "                                    F   ::J\n",
            '                                   /     ::\\      ',
            "              \r",
            "                              __.-'      :::`-.__\n",
            "                             (_           ::::::_)\n",
            "                               `\"\"\"---------\"\"\"'"].join
  def get_user_input(prompt)
    system 'clear'
    print "#{prompt}\n"
    input = gets.chomp
    until yield(input)
      system 'clear'
      print "invalid input\n#{prompt}\n"
      input = gets.chomp
    end
    yield(input).to_a
  end

  def award_winner
    print @board
    sleep 2
    system 'clear'
    print TROPHY
    name = win?(1) ? @board.player_one_name : @board.player_two_name
    print "CONGRADS YOU WIN #{name}"
  end

  def get_slot_from_user(name, number, board)
    prompt = ["#{board}please enter the number of the slot",
              " you want to insert your piece in\n#{name}\n",
              "Player\t#{number}"].join
    get_user_input(prompt) do |selected_slot|
      non_empty_slots =
        (1..board.size).to_a.reject { |slot| board.slot_full?(slot) }
      if non_empty_slots.include?(selected_slot.to_i)
        selected_slot.match(/(#{non_empty_slots.reverse.join("|")})/)
      end
    end[0]
  end

  def make_player(player_number)
    player_name = get_user_input("your name player #{player_number}") do |name|
      name.match(/\w+/)
    end[0]
    Player.new(player_name)
  end

  def print_trophy; end
end
