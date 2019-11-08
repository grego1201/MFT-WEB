# frozen_string_literal: true

class MakeDecision
  HEIGHT_DIFF_ERROR = -5

  def initialize(params)
    @fencer1 = initialize_fencer(params[:fencer1])
    @fencer2 = initialize_fencer(params[:fencer2])
  end

  def obtain_decision
    experience = obtain_experience
    distance = obtain_distance
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

  def initialize_fencer(fencer_options)
    {
      age: fencer_options[:age].to_i,
      intimidated: fencer_options[:intimidated].to_i,
      height: fencer_options[:height].to_i,
      grip: fencer_options[:grip]
    }
  end

  def obtain_experience
    age1 = @fencer1[:age]
    age2 = @fencer2[:age]

    if @fencer2[:intimidated]
      if age1 > age2
        return 0
      else
        return 1
      end
    else
      if age1 < age2
        return 1
      else
        return 2
      end
    end
  end

  def obtain_distance
    height_difference = @fencer1[:height] - @fencer2[:height]
    grip_distance = obtain_grip_distance

    if height_difference > HEIGHT_DIFF_ERROR
      case grip_distance
      when 0 || 1
        return 0
      when 2
        return 1
      end
    elsif height_difference < HEIGHT_DIFF_ERROR * -1
      case grip_distance
      when 0
        return 1
      when 1 || 2
        return 2
      end
    else
      return grip_distance
    end
  end

  def obtain_grip_distance
    grip1 = @fencer1[:grip]
    grip2 = @fencer2[:grip]

    if grip1 == grip2
      return 1
    elsif grip1 == 'French'
      return 0
    else
      return 2
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
