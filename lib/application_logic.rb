module ApplicationLogic

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
