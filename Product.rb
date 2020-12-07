class Product
	attr_accessor :brand_name, :product_name, :cost_price
	
	def initialize(brand: brand_name, product: product_name, price: cost_price)
		@brand_name = brand
		@product_name = product
		@cost_price = price
	end
end
