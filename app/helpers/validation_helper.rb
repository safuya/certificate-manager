# frozen_string_literal: true

module ValidationHelper
  def error(inst)
    if inst.errors.any?
      ' errors'
    else
      ''
    end
  end
end
