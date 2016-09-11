module NucleicAcidTermsHelper
  def sorted_nucleic_acid_term_name_id
    terms_name_id = NucleicAcidTerm.all.map{ |x| [x.name,x.id] }
    terms_name_id.sort! do |x,y|
      x[0] <=> y[0]
    end 
    return terms_name_id
  end 
end
