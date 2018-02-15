module ApplicationLogic

  #Defines a constant ABBR_MODEL that is a hash. Each key is a model's abbreviation (model.ABBR).
  # Each value is the modle object.

	x = {}
	tables= ActiveRecord::Base.connection.tables.sort
	tables.each do |t|
		begin
			model = t.classify.constantize #can raise NameError
			abbr = model::ABBR              #can also raise NameError
		rescue NameError => e #skip any tables that don't have a corresponding model object, i.e. schema_migrations.
			#"uninitialized constant" error
			next
		end

		x[model::ABBR] = model		
	end
	ABBR_MODEL = x
end
