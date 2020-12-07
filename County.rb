class County
	attr_accessor :name, :tax_rate, :markup
	
	def initialize(county_name: name, county_tax_rate: tax_rate, county_markup: markup)
		@name = county_name
		@tax_rate = county_tax_rate
		@markup = county_markup
	end
end

class MiamiDadeCounty < County
end

class BrowardCounty < County
end

class PalmBeachCounty < County
end
