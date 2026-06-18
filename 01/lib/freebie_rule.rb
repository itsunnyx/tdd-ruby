class FreebieRule 

  CONDITION_FREEBIE = 3
  FREEBIE = 1

  def apply(items_count)
    items_count >= CONDITION_FREEBIE ? FREEBIE : 0
  end

end