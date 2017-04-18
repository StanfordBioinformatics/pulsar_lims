module PlatesConcern
  extend ActiveSupport::Concern
  
  private
	
	def create_wells(plate)
		rows = plate.nrows
		cols = plate.ncols
		(1..rows).each do |r|
			(1..cols).each do |c|
				plate.wells.build({user: plate.user, row: r, col: c})
			end
		end
	end
end
