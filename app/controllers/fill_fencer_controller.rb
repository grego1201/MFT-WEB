# frozen_string_literal: true

require 'net/http'
require 'uri'

class FillFencerController < ApplicationController
  FENCER_CHARS = %w[age intimidated height grip ranking handness weapon].freeze

  def index; end

  def results
    @short_distance = ActiveRecord::Type::Boolean.new.cast(params[:short_distance])
    @agressiveness = ActiveRecord::Type::Boolean.new.cast(params[:agressiveness])
    @blade = ActiveRecord::Type::Boolean.new.cast(params[:blade])
    @second_intention = ActiveRecord::Type::Boolean.new.cast(params[:second_intention])
    @risk = ActiveRecord::Type::Integer.new.cast(params[:risk])
  end

  def obtain_decision
    results = MakeDecision.new(prepare_decision_params).obtain_decision

    results_to_var(results)

    redirect_path = '/fill_fencer/results' + '?locale=' + take_referrer_locale
    redirect_path = add_params_to_path(redirect_path)

    redirect_to redirect_path
  end

  private

  def results_to_var(results)
    @short_distance = results[:short_distance]
    @agressiveness = results[:agressiveness]
    @blade = results[:blade]
    @second_intention = results[:second_intention]
    @risk = results[:risk]
  end

  def add_params_to_path(redirect_path)
    redirect_path += "&short_distance=#{@short_distance}"
    redirect_path += "&agressiveness=#{@agressiveness}"
    redirect_path += "&blade=#{@blade}"
    redirect_path += "&second_intention=#{@second_intention}"
    redirect_path += "&risk=#{@risk}"
    redirect_path
  end

  def prepare_decision_params
    {}.tap do |fencers_params|
      2.times do |index|
        fencer_index = "fencer#{index + 1}".to_sym
        fencers_params.merge!(fencer_index => fencer_chars(index))
      end

      fencers_params[:tableu] = params[:tableu]
    end
  end

  def fencer_chars(index)
    {}.tap do |chars|
      FENCER_CHARS.each do |char|
        chars.merge!(char.to_sym => params[char + (index + 1).to_s])
      end
    end
  end

  def take_referrer_locale
    parsed_locale = request.referrer.split('/').fourth
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : I18n.default_locale.to_s
  end
end
