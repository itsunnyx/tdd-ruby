# frozen_string_literal: true

require_relative '../lib/freebie_rule_repository'

describe FreebieRuleRepository do
  it 'loads the active freebie rule from the database' do
    rule = described_class.new.find_active

    expect(rule.apply(3)).to eq(1)
  end
end
