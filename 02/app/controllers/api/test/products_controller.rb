module Api
  module Test
    class ProductsController < ApplicationController

      skip_before_action :verify_authenticity_token
      
      def create_from_list
        products = params[:products].map do |product|
          Product.create!(
            slug: product[:slug], 
            name: product[:name], 
            price: product[:price]
          )
        end
        render json: products, status: :created
      end

      def delete_from_list
        products = Product.where(slug: params[:slugs])
        products.destroy_all
        render json: { message: "Products deleted" }, status: :ok
      end
    end
  end
end