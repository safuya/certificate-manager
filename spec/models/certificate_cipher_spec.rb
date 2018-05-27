# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CertificateCipher do
  let(:certificate) { Certificate.create(url: 'bob.com') }
  let(:cipher) { Cipher.create(name: 'TLA') }

  it 'has a #comment' do
    certificate.ciphers << cipher
    certificate.save
    cc = CertificateCipher.find_by(certificate: certificate.id,
                                   cipher: cipher.id)
    cc.comment = 'Test comment'
    expect(cc).to be_valid
  end

  it 'has a #certificate_url' do
    certificate.ciphers << cipher
    certificate.save
    cc = CertificateCipher.find_by(certificate: certificate.id,
                                   cipher: cipher.id)
    expect(cc.certificate_url).to eql('bob.com')
  end

  it 'has a #cipher_name' do
    certificate.ciphers << cipher
    certificate.save
    cc = CertificateCipher.find_by(certificate: certificate.id,
                                   cipher: cipher.id)
    expect(cc.cipher_name).to eql('TLA')
  end
end
