class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
		if user.nil?
			raise Pundit::NotAuthorizedError
		end
    @user = user
    @record = record
  end

  def index?
	  user.role >= User::VIEWER_ROLE 
  end

  def show?
    #scope.where(:id => record.id).exists?
		user.role >= User::VIEWER_ROLE
  end

  def create?
		user.role >= User::MANAGER_ROLE
  end

  def new?
    create?
  end

  def update?
		create?
  end

  def edit?
		update?
  end

  def destroy?
		create?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
			if user.nil?
				raise Pundit::NotAuthorizedError
			end
      @user = user
      @scope = scope
    end

    def resolve
			if user.role >= User::VIEWER_ROLE
        if scope.column_names.include?(:name)
  				return scope.all.order(updated_at: :desc).order(name: :asc)
        else
  				return scope.all.order(updated_at: :desc)
        end
			else
				return scope.none
			end
    end
  end
end

