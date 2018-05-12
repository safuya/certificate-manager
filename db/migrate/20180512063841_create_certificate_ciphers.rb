class CreateCertificateCiphers < ActiveRecord::Migration[5.2]
  def change
    create_table :certificate_ciphers do |t|
      t.belongs_to :certificate, foreign_key: true
      t.belongs_to :cipher, foreign_key: true

      t.timestamps
    end
  end
end
