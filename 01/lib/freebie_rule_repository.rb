# frozen_string_literal: true

require_relative 'freebie_rule'

class FreebieRuleRepository
  def find_active
    row = fetch_from_database
    FreebieRule.new(row[:min_items], row[:count])
  end

  private

  def fetch_from_database
    # In production: query freebie_rules table via ActiveRecord/SQL.
    { min_items: 3, count: 1 }
  end
end
