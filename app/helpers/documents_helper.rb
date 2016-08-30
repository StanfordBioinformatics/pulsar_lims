module DocumentsHelper
  def sorted_document_name_id
    @documents_name_id = Document.all.map{ |x| [x.name,x.id] }
    @documents_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @documents_name_id
  end 
end
