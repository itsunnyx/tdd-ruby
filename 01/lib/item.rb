# frozen_string_literal: true

class Item
  def initialize(name, price)
    @name = name
    @price = price
  end

  # def name
  #   @name
  # end

  attr_reader :price
end
