#

$ ->                                                                                                   
  #Refresh the pcr_master_mixes list in the form when the refresh fa-icon is clicked:            
  $(document).on "click", ".pcr_pcr_master_mix i.refresh", (event) ->                     
    $.get "/pcr_master_mixes/select_options", (responseText,status,jqXHR) ->                     
      $(".pcr_pcr_master_mix select").html(responseText) 

  #Refresh the crispr_modificatins list in the form when the refresh fa-icon is clicked:            
  $(document).on "click", ".pcr_crispr_modification i.refresh", (event) ->                     
    $.get "/crispr_modifications/select_options", (responseText,status,jqXHR) ->                     
      $(".pcr_crispr_modification select").html(responseText) 
