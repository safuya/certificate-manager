class CreateLoadBalancers < ActiveRecord::Migration[5.2]
  def change
    create_table :load_balancers do |t|
      t.string :hostname
      t.string :ip_address

      t.timestamps
    end
  end
end
