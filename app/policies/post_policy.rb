class PostPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  # def index?
  #   true
  # end
  #
  # def update?
  #   # here we can access our context and record
  #   user.admin? || (user.id == record.user_id)
  # end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.author?
  end

  def update?
    user.admin? || (user.author? && user.id == record.user_id)
  end

  def destroy?
    user.admin? || (user.author? && user.id == record.user_id)
  end

  def publish?
    user.admin? || (user.author? && user.id == record.user_id)
  end
end
