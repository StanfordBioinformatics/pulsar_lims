module CloningForDocuments

  def all_documents
    """
    Returns:
        Document::ActiveRecord_Relation.
    """
    document_ids = self.document_ids
    self.part_of_chain.each do |p|
      document_ids.concat(p.document_ids)
    end
    return Document.where(id: document_ids)
  end

  def parent_documents
    return all_documents.where.not(id: self.document_ids)
  end

end
