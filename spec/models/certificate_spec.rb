# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Certificate do
  before do
    @load_balancer = LoadBalancer.create(hostname: 'a', ip_address: '1')
  end

  let(:certificate) do
    Certificate.new(
      url: 'site.com',
      expiration: Date.iso8601('2016-06-29'),
      load_balancer_id: @load_balancer.id,
      ip_address: '123.123.123.123'
    )
  end

  it 'creates new certificates' do
    expect(certificate).to be_valid
  end

  it 'has a load balancer hostname' do
    expect(certificate.load_balancer_hostname).to eql(@load_balancer.hostname)
  end
end
