# frozen_string_literal: true

# Static web pages
class StaticPagesController < ApplicationController
  # before_action :authenticate_user!, only: ['home']

  def home; end

  def help; end

  def about; end

  def contact; end
end
