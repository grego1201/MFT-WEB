class FillFencerController < ApplicationController

  FENCER_CHARS = ["age", "intimidated", "height", "grip"]

  def index
  end

  def obtain_decision
    results = MakeDecision.new(prepare_decision_params).obtain_decision
    @results = results

    @short_distance = results[:short_distance]
    @agressiveness = results[:agressiveness]
    @blade = results[:blade]
    @second_intention = results[:second_intention]

    render '/fill_fencer/results'
  end

  private

  def prepare_decision_params
    {}.tap do |fencers_params|
      2.times do |index|
        fencer_index = "fencer#{index + 1}".to_sym
        {}.tap do |fencer_chars|
          FENCER_CHARS.each do |char|
            fencer_chars.merge!({char.to_sym => params[char + (index + 1).to_s]})
          end
          fencers_params.merge!(fencer_index => fencer_chars)
        end
      end
    end
  end

end
