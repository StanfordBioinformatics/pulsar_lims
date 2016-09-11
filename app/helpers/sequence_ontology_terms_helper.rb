module SequenceOntologyTermsHelper
  def sorted_so_name_id
    terms_name_id = SequenceOntologyTerm.all.map{ |x| [x.name,x.id] }
    terms_name_id.sort! do |x,y|
      x[0] <=> y[0]
    end 
    return terms_name_id
  end 
end
