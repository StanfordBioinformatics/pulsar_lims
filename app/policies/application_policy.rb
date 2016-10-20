class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    #scope.where(:id => record.id).exists?
		user.role >= USER::VIEWER_ROLE
  end

  def create?
		user.role >= USER::MANAGER_ROLE
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

#  def scope
#    Pundit.policy_scope!(user, record.class)
#  end
#
#  class Scope
#    attr_reader :user, :scope
#
#    def initialize(user, scope)
#      @user = user
#      @scope = scope
#    end
#
#    def resolve
#      scope
#    end
#  end
end

