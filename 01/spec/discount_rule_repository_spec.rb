# frozen_string_literal: true

require_relative '../lib/discount_rule_repository'

describe DiscountRuleRepository do
  it 'loads the active discount rule from the database' do
    rule = described_class.new.find_active

    expect(rule.apply(1000)).to eq(900)
  end
end
