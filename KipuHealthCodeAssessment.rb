require 'stringio'
require_relative 'county'
require_relative 'product'
require_relative 'sale'

puts "Select from these counties [1 - Miami-Dade, 2 - Broward, 3 - Palm Beach]. Enter values separated by commas e.g. 1,3"
selected_counties = gets.chomp.split(',')

county_arr = []
selected_counties.each do |county_id|
	county_arr.push(MiamiDadeCounty.new(county_name: 'Miami-Dade', county_tax_rate: 6, county_markup: 25)) if county_id.to_i == 1
	county_arr.push(BrowardCounty.new(county_name: 'Broward', county_tax_rate: 7, county_markup: 30)) if county_id.to_i == 2
	county_arr.push(PalmBeachCounty.new(county_name: 'Palm Beach', county_tax_rate: 8, county_markup: 30)) if county_id.to_i == 3
end
puts "\nSelected county(ies) to calculate profit from the Sale transaction:"
county_arr.each {|county| puts "#{county.name} "}
puts "\n"

puts "Enter the product name"
product_name = gets.chomp
puts "Enter the brand name of the product"
brand_name = gets.chomp
puts "Enter the cost price of the product"
cost_price = (Float(input = gets.chomp) rescue false) ? input : 0
puts "Enter the units sold for the product"
units_sold = (Integer(input = gets.chomp) rescue false) ? input : 0

begin
	abort if (product_name.strip.length == 0 || brand_name.strip.length == 0 || cost_price == 0 || units_sold == 0)
rescue SystemExit
	p "Exiting the program due to invalid or missing inputs for the Product..."
end

product = Product.new(brand: brand_name, product: product_name, price: cost_price)
total_cost_price = 0
total_sale_price = 0
total_sale_price_with_tax = 0
total_sale_profit = 0

sale = Sale.new
sale_report = StringIO.new
sale_report << "\nSt. Bernard SALE REPORT for product #{product.product_name} and brand #{product.brand_name}.\n"

begin
	cost_price_by_county = 0
	sale_price_by_county = 0
	sale_price_with_tax_by_county = 0
	sale_profit_by_county = 0

	county_arr.each do |county|
		cost_price_by_county, sale_price_by_county, sale_price_with_tax_by_county, sale_profit_by_county = sale.process_transaction_by_county(product, units_sold, county)

		sale_report <<  sale.generate_transaction_report_by_county(county.name, cost_price_by_county, sale_price_by_county, sale_price_with_tax_by_county, sale_profit_by_county)
		
		total_cost_price += cost_price_by_county
		total_sale_price += sale_price_by_county
	end
	
	total_profit, total_profit_percent = sale.calculate_total_profit(total_cost_price, total_sale_price)
	
	sale_report << sale.generate_total_transaction_report(total_cost_price, total_sale_price, total_profit, total_profit_percent)
	
	puts sale_report.string
rescue StandardError => e
	puts "Error occurred: #{e}"
end
