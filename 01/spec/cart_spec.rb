# frozen_string_literal: true

require_relative '../lib/cart'
require_relative '../lib/item'

RSpec.describe Cart do
  #Total amount rule
  it 'Given empty item, total amount should be 0, not freebie' do
    cart = Cart.new([])

    expect(cart.calculateAmount).to eq(0)
  end
  it 'Given 1 item with price 10, total amount should be 10' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 10)
      ]
    )
    expect(cart.calculateAmount).to eq(10)
  end
  it 'Given 2 item with price 500 and 400, total amount should be 1200' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 500),
        Item.new(name: "Apple", price: 400)
      ]
    )
    expect(cart.calculateAmount).to eq(900)
  end

  #Discount rule
  it 'Given 2 item with price 600 and 600, total amount should be 1080' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 600),
        Item.new(name: "Apple", price: 600)
      ]
    )
    expect(cart.calculateAmount).to eq(1080)
  end

  it 'Given 3 item with 200 and 200 and 200, total amount should be 600' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 200),
        Item.new(name: "Apple", price: 200),
        Item.new(name: "Apple", price: 200)
      ]
    )
    expect(cart.calculateAmount).to eq(600)
  end

  #Freebie rule
  it 'Given empty item, get 0 freebie' do
    cart = Cart.new(
      []
    )
    expect(cart.getFreebie).to eq(0)
  end

  it 'Given 3 item, get 1 freebie' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 200),
        Item.new(name: "Apple", price: 200),
        Item.new(name: "Apple", price: 200)
      ]
    )
    expect(cart.getFreebie).to eq(1)
  end

  it 'Given 3 item, get 0 freebie' do
    cart = Cart.new(
      [
        Item.new(name: "Apple", price: 200),
        Item.new(name: "Apple", price: 200)
      ]
    )
    expect(cart.getFreebie).to eq(0)
  end
end
