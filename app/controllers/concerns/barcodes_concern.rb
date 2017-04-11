module BarcodesConcern
  extend ActiveSupport::Concern
  
  private


# Note: add_barcodes isn't used now as it has been replaced with model level methods in the library.
  def add_barcodes(model_obj,barcode_ids)
    """ 
    Function : Adds Barcode associations to the self.barcodes attr. 
    Args     : barcode_ids - Array of Barcode primary key IDs.
    """
    if barcode_ids.blank?
      return model_obj
		elsif barcode_ids.is_a?(String)
			barcode_ids = Array(barcode_ids)
    end 
    barcode_ids.each do |bc| 
      if not bc.empty?
        record = Barcode.find(bc)
        if not model_obj.barcodes.include? record
          model_obj.barcodes << record
        end 
      end 
    end 
		return model_obj
  end
end
