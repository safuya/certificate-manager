# frozen_string_literal: true

class LoadBalancersController < ApplicationController
  def index
    @load_balancers = LoadBalancer.all
  end
end
