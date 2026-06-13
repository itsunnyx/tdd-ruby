# frozen_string_literal: true

require_relative '../lib/freebie_rule'

describe FreebieRule do
  let(:rule) { FreebieRule.new(3, 1) }

  it 'returns 0 when below minimum items' do
    expect(rule.apply(2)).to eq(0)
  end

  it 'returns freebie count when at minimum items' do
    expect(rule.apply(3)).to eq(1)
  end

  it 'returns freebie count when above minimum items' do
    expect(rule.apply(5)).to eq(1)
  end
end
