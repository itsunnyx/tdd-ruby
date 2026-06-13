# frozen_string_literal: true

require_relative '../lib/discount_rule'

describe DiscountRule do
  let(:rule) { DiscountRule.new(1000, 0.9) }

  it 'returns the total when below threshold' do
    expect(rule.apply(999)).to eq(999)
  end

  it 'applies discount when at threshold' do
    expect(rule.apply(1000)).to eq(900)
  end

  it 'applies discount when above threshold' do
    expect(rule.apply(2000)).to eq(1800)
  end
end
