# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cipher do
  it 'creates a cipher' do
    cipher = Cipher.new(name: 'TLS_DHE_RSA_WITH_AES_128_CBC_SHA', secure: true)
    expect(cipher).to be_valid
  end

  it 'defaults secure to false' do
    cipher = Cipher.new(name: 'TLA_LOT_SOF_NON_SEN_SE')
    expect(cipher.secure).to be false
  end
end
