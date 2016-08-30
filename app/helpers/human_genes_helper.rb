module HumanGenesHelper
  def sorted_gene_name_id
    @genes_name_id = HumanGene.all.map{ |x| [x.encode_identifier,x.id] }
    @genes_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @genes_name_id
  end
end
