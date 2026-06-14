# frozen_string_literal: true

class FreebieRule
  def initialize(min_items, count)
    @min_items = min_items
    @count = count
  end

  def apply(item_count)
    item_count >= @min_items ? @count : 0
  end
end
