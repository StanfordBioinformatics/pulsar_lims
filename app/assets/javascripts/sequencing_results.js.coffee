
$ -> 

 # When adding a new SequencingResult (i.e. on the show view of a SequencingRun), if this represents
 # a merged FASTQ file (i.e. merged R1 or merged R2), then it makes no sense to set a Library 
 # or barcode; thus, disable those two fields. 
 check_merged_result = ->
   if $("#sequencing_result_merged").prop("checked")
     $("#sequencing_result_library_id").val("").attr("disabled", true)
     $("#sequencing_result_barcode_id").val("").attr("disabled", true)
   else
     $("#sequencing_result_library_id").val("").attr("disabled", false)
     $("#sequencing_result_barcode_id").val("").attr("disabled", false)
   
   
 $(document).on "change", "#sequencing_result_merged",  check_merged_result
 check_merged_result()
