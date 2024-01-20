# frozen_string_literal: true

# Helpers
module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = 'Kollections App'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  # Returns the bootstrap alert class for a given flash level
  def flash_class(level)
    classes = {
      'notice' => 'alert alert-primary',
      'success' => 'alert alert-success',
      'error' => 'alert alert-error',
      'alert' => 'alert alert-error'
    }

    classes[level]
  end
end
