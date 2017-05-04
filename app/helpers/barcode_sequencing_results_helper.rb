require 'set'

module BarcodeSequencingResultsHelper

	def libs_on_sreq_without_seqresult(sequencing_request)
		sequencing_request_libs = sequencing_request.libraries
		barcode_sequencing_result_libs = get_libraries_on_sequencing_result(sequencing_request.sequencing_result)
		return sequencing_request_libs.reject {|x| 
			barcode_sequencing_result_libs.include?(x)
		}
	end

	def get_libraries_on_sequencing_result(sequencing_result)
		libs = []
		sequencing_result.barcode_sequencing_results.each do |x|
			libs << x.library if x.persisted?
		end
		return libs
	end		


end
