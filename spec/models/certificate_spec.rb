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
    expect(certificate.load_balancer_hostname).to eql('a')
  end

  it 'can have many ciphers' do
    certificate.save
    certificate.ciphers.create(name: 'TLA')
    certificate.ciphers.create(name: 'DES')
    expect(certificate.ciphers.count).to eql(2)
  end

  it 'can list cipher names' do
    certificate.save
    certificate.ciphers.create(name: 'TLA')
    certificate.ciphers.create(name: 'DES')
    expect(certificate.cipher_names).to eql(%w[TLA DES])
  end

  it 'lists certificate vulnerabilities' do
    certificate.save
    certificate.ciphers.create(name: 'TLA', secure: true)
    certificate.ciphers.create(name: 'DES', secure: false)
    expect(certificate.vulnerabilities).to eql(%w[Expired DES])
  end

  it 'tells you all is well if you have no vulnerabilities' do
    its_good = Certificate.create(url: 'good.com',
                                  expiration: Date.today + 30,
                                  ip_address: '10.20.30.40')
    its_good.ciphers.create(name: 'YAY', secure: true)
    expect(its_good.vulnerabilities).to eql(['All good!'])
  end

  it 'lets you search for urls' do
    certificate.save
    Certificate.create(url: 'good.com',
                       expiration: Date.today,
                       ip_address: '10.20.30.40')
    params = { search: 'good.com', filter: 'url' }
    search_results = Certificate.search(params)
    expect(search_results.length).to eql(1)
    expect(search_results[0].url).to eql('good.com')
  end

  it 'lets you search for vulnerabilities' do
    certificate.save
    Certificate.create(url: 'good.com',
                       expiration: Date.tomorrow,
                       ip_address: '10.20.30.40')
    params = { search: 'Expired', filter: 'vulnerabilities' }
    search_results = Certificate.search(params)
    expect(search_results.length).to eql(1)
    expect(search_results[0].url).to eql('site.com')
  end

  it 'lets you search for ciphers' do
    certificate.save
    certificate.ciphers.create(name: 'DES')
    Certificate.create(url: 'good.com',
                       expiration: Date.tomorrow,
                       ip_address: '10.20.30.40')
    params = { search: 'DES', filter: 'ciphers' }
    search_results = Certificate.search(params)
    expect(search_results[0].url).to eql(certificate.url)
  end
end
