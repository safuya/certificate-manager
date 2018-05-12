# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Certificate do
  let(:certificate) do
    Certificate.new(
      url: 'site.com',
      expiration: Date.iso8601('2016-06-29'),
      ip_address: '123.123.123.123'
    )
  end

  it 'creates new certificates' do
    expect(certificate).to be_valid
  end

  it 'has a load balancer hostname' do
    certificate.save
    certificate.create_load_balancer(hostname: 'a', ip_address: '1')
    expect(certificate.load_balancer_hostname).to eql(@load_balancer.hostname)
  end
end
