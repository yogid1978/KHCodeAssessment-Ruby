class Sale
	def process_transaction_by_county(product, units_sold, county)
		county_cost_price = '%.2f' % Sale.multiply(product.cost_price, units_sold).to_f
		county_sale_price = '%.2f' % Sale.multiply(county_cost_price, (1 + county.markup.to_f/100)).to_f
		county_sale_price_with_tax = '%.2f' % Sale.multiply(county_sale_price, (1 + county.tax_rate.to_f/100)).to_f
		county_sale_profit = '%.2f' % (county_sale_price.to_f - county_cost_price.to_f)

		return county_cost_price.to_f, county_sale_price.to_f, county_sale_price_with_tax.to_f, county_sale_profit.to_f
	end
	
	def calculate_total_profit(total_cost_price, total_sale_price)
		total_profit = '%.2f' % (total_sale_price.to_f - total_cost_price.to_f);
		total_profit_percent = '%.2f' % ((total_profit.to_f / total_cost_price.to_f) * 100);

		return total_profit.to_f, total_profit_percent.to_f
	end
	
	def generate_transaction_report_by_county(county_name, county_cost_price, county_sale_price, county_sale_price_with_tax, profit)
		str = StringIO.new
		str << "\n#{county_name} County Sale: ";
		str << "County CostPrice - $#{'%.2f' % county_cost_price}, "
		str << "County SalePrice - $#{'%.2f' % county_sale_price}, "
		str << "County SalePrice plus Tax - $#{'%.2f' % county_sale_price_with_tax}, "
		str << "County Profit - #{'%.2f' % profit}\n"

        str.string
	end
	
	def generate_total_transaction_report(total_cost_price, total_sale_price, total_profit, total_profit_percent)
		str = StringIO.new
		str << "\nTotal Sale: ";
		str << "Total CostPrice - $#{'%.2f' % total_cost_price}, "
		str << "Total SalePrice - $#{'%.2f' % total_sale_price}, "
		str << "Total Profit - $#{'%.2f' % total_profit}, "
		str << "Total Profit Percent - #{'%.2f' % total_profit_percent}\n"

        str.string
	end
	
	private
		def self.multiply x, y
			return '%.2f' % (x.to_f * y.to_f)
		end
end
