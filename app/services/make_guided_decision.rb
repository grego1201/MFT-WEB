# frozen_string_literal: true

class MakeGuidedDecision
  def initialize(options)
    @age = options['age']
    @distance = options['distance']
    @intimidated = options['intimidated']
  end

  def obtain_decision
    experience = obtain_experience
    agressiveness = obtain_agressiveness(experience)
    short_distance = short_distance?(@distance, agressiveness)
    blade = short_distance
    second_intention = second_intention?(short_distance, experience)
    { agressiveness: agressiveness, short_distance: short_distance,
      blade: blade, second_intention: second_intention }
  end

  private

  def obtain_experience
    if @intimidated.positive?
      @age == 2 ? 0 : 1
    elsif @age.zero?
      1
    else
      2
    end
  end

  def obtain_agressiveness(experience)
    return true if experience.zero?

    false
  end

  def short_distance?(distance, agressiveness)
    return false if [1, 2].include?(distance)

    agressiveness
  end

  def second_intention?(short_distance, experience)
    return false if short_distance
    return true if experience.zero?

    false
  end
end
