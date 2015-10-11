class Building < ActiveRecord::Base

	def build(items_it_needs)
		# Gets the building company that has everything the user needs to start construction
		# Can higher more than one company at a time.
		# Needed worker for each construction = 1? Or more? Calculated based on total demand for construction and total builders?
		# Machines make building faster and cheaper?
	end

end