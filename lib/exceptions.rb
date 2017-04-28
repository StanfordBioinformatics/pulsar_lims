module Exceptions

	class BarcodeNotFoundError < StandardError
	end

	class TooManyRowsError < StandardError
	end

	class TooManyColumnsError < StandardError
	end

	class WellNotFoundError < StandardError
	end
	
	class WellAndPlateMismatchError < StandardError
	end

end
