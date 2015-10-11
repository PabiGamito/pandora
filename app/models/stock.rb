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

	# TODO CHECK IF THIS CAN RUN
	# Move items to a new storage facility
	def move(amount, new_storage_id)
		if amount<=self.amount
			receiving_company_id=Building.find(new_storage_id).company_id
			receiving_company_stock=Stock.find_by(company_id: receiving_company_id)
			if receiving_company_stock==nil
				Stock.create(company_id: receiving_company_id, amount: amount, item_id: self.item_id)
			else
				Stock.find_by(company_id: receiving_company_id, item_id: self.item_id).update(amount: amount)
			end

			# Remove stock from sending storage facility
			self.update(amount: self.amount -= amount)

			# Pay shipping costs
			# Random time calculated between companies. But always the same for each company.
			# Should be calculated based on name of the company or company id, so that time of delivery between two same companies is always the same, but not with others

		end
	end

	def test
	# THIS WORKS
		self.update(amount: self.amount += 10)
		return self.amount
		# return self.item_id
		# return Stock.find(1)
	end

end