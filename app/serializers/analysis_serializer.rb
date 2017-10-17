class AnalysisSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :user
end
