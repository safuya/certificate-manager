# frozen_string_literal: true

module ValidationHelper
  def error(instance, field)
    if instance.errors[field].any?
      ' errors'
    else
      ''
    end
  end
end
