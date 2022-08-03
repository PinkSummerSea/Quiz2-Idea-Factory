# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Idea do |idea|
      user == idea.user
    end

    can :crud, Review do |review|
      user == review.user
    end

    can :destory, Like do |like|
      user == like.user
    end

    # quiz does not require that idea author cannot like their own idea. so didn't set up any limitations here.

  end
end
