class AddCommentToCertificateCiphers < ActiveRecord::Migration[5.2]
  def change
    remove_column :certificate_ciphers, :audited_date
    add_column :certificate_ciphers, :comment, :string
  end
end
