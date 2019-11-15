# frozen_string_literal: true

# player is just a instance containing the name
class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
