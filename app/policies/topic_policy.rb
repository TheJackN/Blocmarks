class TopicPolicy < ApplicationPolicy
  attr_reader :user, :topic

  def initialize(user, topic)
    @topic = topic
    @user = user
  end

  def index?
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && user == topic.user
  end

  def update?
    user.present? && user == topic.user
  end

  def destroy?
    user.present? && (topic.user == user)
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user, @scope = user, scope
    end

    def resolve
      if user == nil
        return scope.all
      else
        return scope.all.select {|t| t.user == user }
      end
    end
  end

end
