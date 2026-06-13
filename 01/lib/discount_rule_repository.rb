# frozen_string_literal: true

require_relative 'discount_rule'

class DiscountRuleRepository
  def find_active
    row = fetch_from_database
    DiscountRule.new(row[:threshold], row[:discount])
  end

  private

  def fetch_from_database
    # In production: query discount_rules table via ActiveRecord/SQL.
    { threshold: 1000, discount: 0.9 }
  end
end
