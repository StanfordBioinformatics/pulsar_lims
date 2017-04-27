module Exceptions

	class BarcodeNotFoundError < StandardError
	end

	class TooManyRowsError < StandardError
	end

	class TooManyColumnsError < StandardError
	end

end
