# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Idea do |idea|
      user == idea.user
    end
  end
end
