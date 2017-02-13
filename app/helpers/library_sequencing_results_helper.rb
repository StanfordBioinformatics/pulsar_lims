require 'set'

module LibrarySequencingResultsHelper

	def libs_on_sreq_without_seqresult(sequencing_request)
		sequencing_request_libs = sequencing_request.libraries
		library_sequencing_result_libs = get_libraries_on_sequencing_result(sequencing_request.sequencing_result)
		return sequencing_request_libs.reject {|x| 
			library_sequencing_result_libs.include?(x)
		}
	end

	def get_libraries_on_sequencing_result(sequencing_result)
		libs = []
		sequencing_result.library_sequencing_results.each do |x|
			libs << x.library
		end
		return libs
	end		
end
