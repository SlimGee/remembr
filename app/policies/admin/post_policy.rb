class Admin::PostPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  def index?
    manage? || user.has_role?(:author)
  end

  def update?
    manage? || (user.has_role?(:author) && owner?)
  end

  def destroy?
    manage? || (user.has_role?(:author) && owner?)
  end

  def publish?
    manage? || (user.has_role?(:author) && owner?)
  end

  def new?
    manage? || user.has_role?(:author)
  end

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
end
