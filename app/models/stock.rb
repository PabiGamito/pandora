class Stock < ActiveRecord::Base

def self.create_stock
	companies=Company.where(sector: 1)
	companies.push(*Company.where(sector: 2))
	companies.each do |company|

		iq=0
		efficiency=0
		focus=0
		quality=0
		happiness=0

		Employe.where(company_id: company.id, category: 1).each do |employee|
			iq+=employee.iq
			efficiency+=employee.efficiency
			focus+=employee.focus
			quality+=employee.quality
			happiness+=employee.happiness
		end

		production_per_hour=mine_level

		if company.specialize < 200
			if company.specialize == 100
				Building.where(company_id: company.id, name: "granor mine").each do |building|
					building.level
				end
			elsif company.specialize == 101

			elsif company.specialize == 102

			end
		elsif company.specialize < 300
			if company.specialize == 200

			elsif company.specialize == 201

			elsif company.specialize == 202

			end
		end

	end
end

end