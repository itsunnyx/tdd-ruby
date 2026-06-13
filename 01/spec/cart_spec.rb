# frozen_string_literal: true

require_relative '../lib/cart'
require_relative '../lib/item'

describe Cart do
  it 'starts with zero subtotal' do
    expect(Cart.new.subtotal).to eq(0)
  end

  it 'starts with zero items' do
    expect(Cart.new.item_count).to eq(0)
  end

  it 'adds item prices to subtotal' do
    cart = Cart.new
    cart.add_item(Item.new('Item 1', 10))
    cart.add_item(Item.new('Item 2', 20))

    expect(cart.subtotal).to eq(30)
    expect(cart.item_count).to eq(2)
  end
end
