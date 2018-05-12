class CreateCiphers < ActiveRecord::Migration[5.2]
  def change
    create_table :ciphers do |t|
      t.string :name
      t.boolean :secure, default: false

      t.timestamps
    end
  end
end
