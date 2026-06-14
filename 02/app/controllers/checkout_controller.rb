class CheckoutController < ApplicationController
  
  def index
    @cart = Cart.new(self.itemsFromParams)
    @checkout = Checkout.new(@cart, discount_rule: DiscountRule.new(1000, 0.9), freebie_rule: FreebieRule.new(3, 1))
  end

  private 
    def itemsFromParams
      Array(params[:items])
        .map { |id| Product.find_by(slug: id) }
        .compact
        .map { |product| Item.new(product.name, product.price) }
    end
end
