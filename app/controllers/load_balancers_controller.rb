# frozen_string_literal: true

class LoadBalancersController < ApplicationController
  before_action :authenticate!

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

  def new
    @load_balancer = LoadBalancer.new
    @certificates = Certificate.all
  end

  def create
    @load_balancer = LoadBalancer.new(load_balancer_params)
    if @load_balancer.save
      redirect_to load_balancers_url
    else
      flash[:error] = @load_balancer.errors.full_messages.to_sentence
      @certificates = Certificate.all
      render :new
    end
  end

  private

  def load_balancer_params
    params.require(:load_balancer)
          .permit(:hostname, :ip_address, certificate_ids: [])
  end
end
