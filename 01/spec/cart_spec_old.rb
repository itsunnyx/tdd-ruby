# frozen_string_literal: true

require_relative '../lib/cart'

RSpec.describe Cart do
  it 'test calculateAmount : have 10 quantity == have discount' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      10
    )
    expect(cart.calculateAmount()).to eq(900)
  end

  it 'test calculateAmount : have 20 quantity == have discount' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      20
    )
    expect(cart.calculateAmount()).to eq(1800)
  end

  it 'test calculateAmount : have 5 quantity == have not discount' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      5
    )
    expect(cart.calculateAmount()).to eq(500)
  end

  it 'test calculateGiveAway : have 3 quantity == have giveaway' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      3
    )
    expect(cart.calculateGiveAway()).to eq("GiveAway<3")
  end

  it 'test calculateGiveAway : have 10 quantity == have giveaway' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      10
    )
    expect(cart.calculateGiveAway()).to eq("GiveAway<3")
  end

  it 'test calculateGiveAway : have 1 quantity == have not giveaway' do
    cart = Cart.new(
      {
        name: "Apple",
        price: 100
      },
      1
    )
    expect(cart.calculateGiveAway()).to eq("Not GiveAway!!")
  end
  
end
