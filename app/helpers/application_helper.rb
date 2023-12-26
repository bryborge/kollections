# frozen_string_literal: true

# Helpers
module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = 'Kollections App'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
