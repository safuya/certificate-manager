# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoadBalancer do
  let(:load_balancer) do
    LoadBalancer.new(hostname: 'lb01.room101.com', ip_address: '10.101.20.5')
  end

  it 'creates new load balancers' do
    expect(load_balancer).to be_valid
  end
end
