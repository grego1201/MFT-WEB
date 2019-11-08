# frozen_string_literal: true

module ViewsHelper
  def actual_full_path
    parsed_locale = request.original_fullpath.split('/').second
    path = request.original_fullpath.split('/')
    parsed_path = I18n.available_locales.map(&:to_s).include?(parsed_locale) ? path[2..-1] : path[1..-1]
    parsed_path.nil? ? '/' : parsed_path.join('/')
  end

  def rb_yne(form_label)
    answers = %w[y n eq]
    tags = html_escape('')
    tags << label_tag(:form_label, I18n.t("guided.form.#{form_label}"))
    tags << '<br/>'.html_safe
    answers.each do |answer|
      tags << radio_button_tag(form_label, answer.to_s)
      tags << I18n.t("guided.form.answers.#{answer}")
      tags << '<p/>'.html_safe
    end
    tags
  end

  def add_locale_to_url(destination_url)
    '/' + I18n.locale.to_s + destination_url
  end

  def swap_locale
    locale = I18n.locale.to_s == 'es' ? 'en' : 'es'
    '/' + locale + '/' + actual_full_path.split('?').first.to_s
  end
end
