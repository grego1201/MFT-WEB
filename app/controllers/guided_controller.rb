# frozen_string_literal: true

class GuidedController < ApplicationController
  FENCER_CHARS = %w[age intimidated age].freeze

  def index; end

  def obtain_decision
    results = MakeGuidedDecision.new(prepare_decision_params).obtain_decision
    @results = results

    @short_distance = results[:short_distance]
    @agressiveness = results[:agressiveness]
    @blade = results[:blade]
    @second_intention = results[:second_intention]

    redirect_path = '/guided/results' + '?locale=' + take_referrer_locale
    redirect_to redirect_path
  end

  private

  def prepare_decision_params
    prepared_params = params.permit(:age, :distance, :intimidated)
    prepared_params[:distance] = normalize_yne(params[:distance])
    prepared_params[:age] = normalize_yne(params[:age])
    prepared_params[:intimidated] = prepared_params[:intimidated].to_i
    prepared_params
  end

  def normalize_yne(answer)
    case answer
    when 'y'
      0
    when 'eq'
      1
    when 'n'
      2
    end
  end

  def take_referrer_locale
    parsed_locale = request.referrer.split('/').fourth
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : I18n.default_locale.to_s
  end
end
