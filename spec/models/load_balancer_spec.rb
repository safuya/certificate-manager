# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoadBalancer do
  let(:load_balancer) do
    LoadBalancer.new(hostname: 'lb01.room101.com', ip_address: '10.101.20.5')
  end

  it 'creates new load balancers' do
    expect(load_balancer).to be_valid
  end

  it 'has a unique hostname' do
    load_balancer.save
    duplicate = LoadBalancer.new(hostname: 'lb01.room101.com',
                                 ip_address: '10.101.20.15')
    expect(duplicate).to_not be_valid
  end

  it 'has to have a hostname' do
    blank_lb = LoadBalancer.new
    expect(blank_lb).to_not be_valid
  end
end
