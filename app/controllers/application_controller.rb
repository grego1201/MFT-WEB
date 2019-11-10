# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_current_page

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_path || I18n.default_locale
  end

  def extract_locale_from_path
    parsed_locale = request.original_fullpath.split('/').second
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def set_current_page
    path = request.path.split('/')[2..-1].join('/')
    @current_page = path.empty? ? 'home' : path.split('/').first
  end
end
