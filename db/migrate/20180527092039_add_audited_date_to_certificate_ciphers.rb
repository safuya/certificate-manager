class AddAuditedDateToCertificateCiphers < ActiveRecord::Migration[5.2]
  def change
    add_column :certificate_ciphers, :audited_date, :date
  end
end
