class CreateCertificates < ActiveRecord::Migration[5.2]
  def change
    create_table :certificates do |t|
      t.string :url
      t.date :expiration
      t.belongs_to :load_balancer, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
