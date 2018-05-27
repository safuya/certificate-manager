# frozen_string_literal: true

module ValidationHelper
  def error(inst, field)
    if inst.errors[field].any?
      ' errors'
    else
      ''
    end
  end
end
