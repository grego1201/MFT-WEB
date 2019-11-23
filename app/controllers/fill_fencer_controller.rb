# frozen_string_literal: true

require 'net/http'
require 'uri'

class FillFencerController < ApplicationController
  FENCER_CHARS = %w[age intimidated height grip ranking handness weapon].freeze

  def index; end

  def obtain_decision
    make_request
    results = MakeDecision.new(prepare_decision_params).obtain_decision
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

  def make_request
    uri = URI.parse('https://mftapi.herokuapp.com/predict/')
    request = Net::HTTP::Get.new(uri)
    request.set_form_data(test_method)

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    response.code
  end

  def test_method
    {
      'fencer1_age' => '26',
      'fencer1_handness' => '0',
      'fencer1_ranking' => '33',
      'fencer1_weapon' => '1.0',
      'fencer2_age' => '44',
      'fencer2_handness' => '0',
      'fencer2_ranking' => '99999999',
      'fencer2_weapon' => '1.0',
      'tableu' => '16'
    }
  end
end
