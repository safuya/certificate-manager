# frozen_string_literal: true

class LoadBalancersController < ApplicationController
  def index
    @load_balancers = LoadBalancer.all
  end

  def edit
    @load_balancer = LoadBalancer.find(params[:id])
    @certificates = Certificate.all
  end

  def update
    load_balancer = LoadBalancer.find(params[:id])
    load_balancer.update(load_balancer_params)
    redirect_to load_balancers_url
  end

  private

  def load_balancer_params
    params.require(:load_balancer).permit(:hostname, :ip_address,
                                          certificate_ids: [])
  end
end
