class AtacseqSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :submitter_comments, :notes
  has_one :user
end
