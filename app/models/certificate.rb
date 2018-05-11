class Certificate < ApplicationRecord
  belongs_to :load_balancer

  def load_balancer_hostname
    load_balancer.hostname
  end
end
