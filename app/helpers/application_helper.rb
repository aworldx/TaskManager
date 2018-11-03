# frozen_string_literal: true

module ApplicationHelper
  def flash_alert_class(flash_type)
    "alert-#{flash_type.to_s == 'notice' ? 'success' : 'danger'}"
  end
end
