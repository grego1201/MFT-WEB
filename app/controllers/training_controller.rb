# frozen_string_literal: true

class TrainingController < ApplicationController
  ACTIONS = I18n.t('training.actions')

  def index
    @actions = ACTIONS
  end

  def calculate_random
    redirect_path = '/training/show_random' + '?locale=' + take_referrer_locale
    redirect_path += '&actions_number=' + params[:actions_number]
    redirect_to redirect_path
  end

  def show_random
    @actions = ACTIONS
    @generated_actions = ACTIONS.sample(params[:actions_number].to_i)
  end

  private

  def take_referrer_locale
    parsed_locale = request.referrer.split('/').fourth
    return parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)

    parsed_locale = take_locale_from_params
    return parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)

    I18n.default_locale.to_s
  end

  def take_locale_from_params
    split_path.select { |k| k.include?('locale') }.first&.split('=')&.last
  end

  def split_path
    request.referrer.split('/').last.split('?').last.split('?').last.split('&')
  end
end
