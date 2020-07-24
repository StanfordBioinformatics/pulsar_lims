class PrimerSerializer < ActiveModel::Serializer
  # disable model name: 
  # https://stackoverflow.com/questions/3577443/rails-rendering-json-data-with-model-root
  # https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
  self.root = false
  
  attributes :id, :name, :description, :notes, :direction, :sequence, :melting_temperature, :date_ordered
  has_one :user
end
