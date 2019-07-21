class MakeGuidedDecision
  def initialize(options)
    @age = options['age']
    @distance = options['distance']
    @intimidated = options['intimidated']
  end

  def obtain_decision
    experience = obtain_experience
    distance = @distance
    agressiveness = obtain_agressiveness(experience)
    short_distance = short_distance?(distance, agressiveness)
    blade = short_distance
    second_intention = second_intention?(short_distance, experience)
    {
      agressiveness: agressiveness,
      short_distance: short_distance,
      blade: blade,
      second_intention: second_intention
    }
  end

  private

  def obtain_experience
    if @intimidated
      if @age == 2
        return 0
      else
        return 1
      end
    else
      if @age == 0
        return 1
      else
        return 2
      end
    end
  end

  def obtain_agressiveness(experience)
    return true if experience == 0
    false
  end

  def short_distance?(distance, agressiveness)
    return false if [1, 2].include?(distance)
    agressiveness
  end

  def second_intention?(short_distance, experience)
    return false if short_distance
    return true if experience == 0
    false
  end
end
