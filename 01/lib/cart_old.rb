class Cart

  attr_reader :amount, :quantity, :product

  def initialize(product, quantity)
    @amount = 0
    @quantity = quantity
    @product = product
  end

  def calculateAmount()
    @amount = @product[:price]*quantity
    if @amount >= 1000
      puts "discount!"
      @amount*0.9
    else
      @amount
    end
  end

  def calculateGiveAway()
    if quantity >= 3
      return "GiveAway<3"
    else
      return "Not GiveAway!!"
    end
  end

  if __FILE__ == $PROGRAM_NAME
    cart = Cart.new(
      {
        name: "Apple",
        price: 1000
      },
      2
    )
    puts cart.calculateAmount()
    puts cart.calculateGiveAway()
  end
end